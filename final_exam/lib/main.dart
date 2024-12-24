import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_exam/add_contact.dart';
import 'package:final_exam/contact.dart';
import 'package:final_exam/contact_provider.dart';
import 'package:final_exam/db.dart';
import 'package:final_exam/setting.dart';

void main() async {
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactProvider(),//!!!!!!!!!!!!!!!!!!!!!!
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
        theme: ThemeData(useMaterial3: false),
      ),
    );
  }
}

class MainPage extends StatefulWidget {

  const MainPage({Key? key, }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ContactProvider>(context,listen: false).getContact();//!!!!
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<ContactProvider>(context,listen: false).selectContact=-1;//!!!!
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return AddContact();
              },
            ));
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text("contact"),
//-----------------------------------------------
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SettingPage(),
                  ),
                );
              },
              icon: Icon(Icons.settings),
            ),
          ],
//-----------------------------------------------

        ),
        body: Container(
          child: Column(
            children: [
            SizedBox(height: 50,),
              Consumer<ContactProvider>(//!!!!
                builder: (context, value, child) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: value.contacts.length,
                      itemBuilder: (context, index) {
                        Contact contact = value.contacts[index];//!!!!
                        
                        return ListTile(
                       
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueGrey,
                            child: Text(contact.name[0]),
                          ),
                          title: Text(contact.name),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Contact Info"),
                                  content: Container(
                                    height: 80, // تحديد ارتفاع المحتوى
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "name : ${contact.name}",
                                        ),
                                        SizedBox(
                                            height:
                                                10), // إضافة مسافة بين النصوص
                                        Text("phone : ${contact.number}"),
                                      ],
                                    ),
                                  ),
                                  actions: [ElevatedButton(onPressed: (){
                                    Navigator.pop(context);
                                  }, child: Text("cancel"))],
                                );
                              },
                            );
                          },
                          trailing: IconButton(
                              onPressed: () {
                                value.deleteConrtac(contact);
                              },
                              icon: Icon(Icons.delete)),
                                 onLongPress: () {
                            value.selectContact=index;
                            value.selectContactId=contact.id!;
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return AddContact();
                            },));
                          },
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ));
  }
}
