import 'package:flutter/material.dart';
import 'package:final_exam/db.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    SqlDb sqlDb = SqlDb();

    return Scaffold(
      appBar: AppBar(title: Text("setting page"),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:  CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      await sqlDb.deleteDataBase();
                    },
                    child: Text("اعادة عمل قاعدة البيانات")),
              ),
                  SizedBox(height: 50,),
              SizedBox(
                width: double.infinity,
          
                child: ElevatedButton(
                    onPressed: () async {
                      sqlDb.createNewTable(
                        "person",
                        {
                          'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
                          'name': 'TEXT NOT NULL',
                          'age': 'INTEGER',
                        },
                      );
                    },
                    child: Text(" اضافة جدول جديد")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
