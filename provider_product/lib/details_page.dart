import 'package:flutter/material.dart';
import 'package:provider_product/invoice_model.dart';
import 'package:provider/provider.dart';


class DetailsPage extends StatelessWidget {
  
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Consumer<InvoiceModel>(builder: (context, value, child) {
          return Text(value.getSelectedInvoice().name);
        },)
      ),
      body: Consumer<InvoiceModel>(builder: (context, value, child) {
        return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Invoice No: ${value.getSelectedInvoice().id}',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            'Products:',
            style: TextStyle(fontSize: 30, color: Colors.red),
          ),
          Text(
            value.getSelectedInvoice().toString(),
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      );
      },)
    );
  }
}
