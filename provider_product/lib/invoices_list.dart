import 'package:flutter/material.dart';
import 'package:provider_product/invoice_model.dart';
import 'package:provider/provider.dart';

class InvoicesList extends StatelessWidget {
  const InvoicesList({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('All Customers'),
      ),
      body: Consumer<InvoiceModel>(builder: (context, value, child) {
        return ListView.builder(
        itemCount: value.getSize(),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListTile(
            onTap: () {
              value.selectedIndex = index;
              Navigator.pushNamed(context, '/details_page');
            },
            tileColor: Colors.blue[100],
            trailing: IconButton(onPressed: () {
              value.selectedIndex = index;
              value.removeInvoice();
            }, icon: Icon(Icons.delete)),
            leading: Text(
             value.getInvoice(index).name,
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
      );
      },)
    );
  }
}
