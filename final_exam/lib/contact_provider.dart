import 'package:flutter/material.dart';
import 'package:final_exam/contact.dart';
import 'package:final_exam/db.dart';

class ContactProvider extends ChangeNotifier {
  List<Contact> contacts = [];
  int selectContact=-1;
  int selectContactId=-1;
  SqlDb db = SqlDb();
  String _tableName = "contact";

  Future<void> addContact(String name, String number) async {
    Contact contact = Contact(name: name, number: number);
    await db.insertData(_tableName, contact.toMap());
    getContact();
  }

  Future<void> getContact() async {
    List<Map<String, dynamic>> data = await db.readData(_tableName);
    contacts = data.map((e) => Contact.fromJson(e)).toList();
    notifyListeners();
  }

  Future<void> editContact(Contact contact) async {
    await db.updateData(_tableName, contact.toMap());
    getContact();
  }
    Future<void> deleteConrtac(Contact contact) async {
    await db.deleteData(_tableName, contact.id!);
    getContact();
  }
  Future<Contact> getSomeContact()async{
    Map<String, dynamic> data = await db.getdata(_tableName,selectContactId);
    return Contact.fromJson(data);
  }

}
