import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }
// ########################

  initDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "contact.db");
    Database myDatabase = await openDatabase(path,
        onCreate: _onCreate, version: 2, onUpgrade: _onUpgrade);
    return myDatabase;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("on upgrade--------------------------------");
  }
// ########################
  _onCreate(Database database, int version) async {
    await database.execute('''
CREATE TABLE contact (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          number TEXT NOT NULL
)
''');
    print("create database done");
  }
// ########################


 Future<List<Map<String, dynamic>>> readData(String tableName) async {
    Database? myDatabase = await db;
    List<Map<String, dynamic>> result = await myDatabase.query(tableName);
    return result;
  }

  Future<int> insertData(String tableName, Map<String, dynamic> data) async {
    final dbs = await db;
    int rawId = await dbs.insert(tableName, data);
    return rawId;
  }

 Future<int> updateData(String tableName, Map<String, dynamic> data) async {
    Database? myDatabase = await db;
    int result = await myDatabase
        .update(tableName, data, where: 'id=?', whereArgs: [data["id"]]);
    return result;
  }

 Future<int> deleteData(String tablename, int index) async {
    Database? myDatabase = await db;
    int result =
        await myDatabase.delete(tablename, where: 'id = ?', whereArgs: [index]);
    return result;
  }

 Future <Map<String, dynamic>> getdata(String tablename, int index) async {
    Database? myDatabase = await db;
    List<Map<String, dynamic>> result =
        await myDatabase.query(tablename, where: 'id = ?', whereArgs: [index]);
    return result.first;
  }
// ########################

  deleteDataBase() async {
    final databasesPath = await getDatabasesPath();
    final dbPath = join(databasesPath, 'contact.db');
    await deleteDatabase(dbPath);
    _db = null;
    await initDatabase();
    print("Database deleted and reinitialized");
// ########################
  }
// --------------------------------------------------------------------------------
  Future<void> createNewTable(String tableName, Map<String, String> columns) async {
  final dbs = await db; 
  String columnsDefinition = columns.entries
      .map((entry) => '${entry.key} ${entry.value}')
      .join(', ');
  String sql = 'CREATE TABLE IF NOT EXISTS $tableName ($columnsDefinition)';
  await dbs.execute(sql);
  print("Table $tableName created successfully.");
}

}
