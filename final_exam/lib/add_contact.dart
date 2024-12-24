import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_exam/contact.dart';
import 'package:final_exam/contact_provider.dart';

class AddContact extends StatefulWidget {
  const AddContact({Key? key}) : super(key: key);

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  int? index;
  Contact? contact;
  bool isLoading = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    index = Provider.of<ContactProvider>(context, listen: false).selectContact;
    if (index != -1) {
      getContact();
    }
  }

  getContact() async {
    contact = await Provider.of<ContactProvider>(context, listen: false)
        .getSomeContact();
    _nameController.text = contact?.name ?? "";
    _numberController.text = contact?.number ?? "";
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(contact != null ? "edit ${contact!.name}" : "add new contact"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              TextField(
                decoration: InputDecoration(labelText: "name"),
                controller: _nameController,
              ),
              TextField(
                decoration: InputDecoration(labelText: "number"),
                controller: _numberController,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if (index != -1) {
                          Contact newContact = Contact(
                              id: contact!.id,
                              name: _nameController.text,
                              number: _numberController.text);
                          Provider.of<ContactProvider>(context, listen: false)
                              .editContact(newContact);
                        } else {
                          Provider.of<ContactProvider>(context, listen: false)
                              .addContact(
                                  _nameController.text, _numberController.text);
                        }
                        Navigator.of(context).pop();
                      },
                      child: Text(index != -1 ? "edit" : "add")))
            ],
          ),
        ),
      ),
    );
  }
}
