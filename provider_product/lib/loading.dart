import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider_product/invoice_model.dart';
import 'invoice.dart';
import 'package:provider/provider.dart';

fetchInvoices(BuildContext context) async {
  var response = await http.get(Uri.parse('https://www.jsonkeeper.com/b/TT8U'));
  if (response.statusCode == 200) {
    var jsonArr = jsonDecode(response.body)['invoices'] as List;
    // Provider.of<InvoiceModel>(context, listen: false).invoices =
    // jsonArr.map((e) => Invoice.fromJson(e)).toList();
    context.read<InvoiceModel>().invoices =
        jsonArr.map((e) => Invoice.fromJson(e)).toList();
  }
  Navigator.pop(context);
  Navigator.pushReplacementNamed(context, '/');
}

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchInvoices(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: SpinKitPouringHourGlass(
          duration: Duration(
            milliseconds: 1000,
          ),
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
