import 'package:flutter/material.dart';
import 'package:provider_product/invoice_model.dart';
import 'package:provider/provider.dart';
import 'details_page.dart';
import 'invoices_list.dart';
import 'invoice.dart';
import 'loading.dart';
import 'product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => InvoiceModel(),
        builder: (context, child) => MaterialApp(
              initialRoute: '/',
              routes: {
                '/': (context) => InvoiceApp(),
                '/invoices_list': (context) => InvoicesList(),
                '/details_page': (context) => DetailsPage(),
                // '/loading': (context) => Loading(),
              },
            ));
  }
}

TextEditingController cNameController = TextEditingController();
TextEditingController pNameController = TextEditingController();
TextEditingController quantityController = TextEditingController();
TextEditingController priceController = TextEditingController();
List<Product> products = [
  Product(name: 'Mouse', quantity: 10, price: 20.3),
  Product(name: 'Ram', quantity: 5, price: 150.5),
];

class InvoiceApp extends StatefulWidget {
  const InvoiceApp({super.key});
  static int invoiceNo = 1;

  @override
  State<InvoiceApp> createState() => _InvoiceAppState();
}

class _InvoiceAppState extends State<InvoiceApp> {
  @override
  Widget build(BuildContext context) {
    if (!context.read<InvoiceModel>().isEmpty()) {
      InvoiceApp.invoiceNo = context.read<InvoiceModel>().getLast().id + 1;
    } else {
      InvoiceApp.invoiceNo = 1;
    }

    return Consumer<InvoiceModel>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text('Invoice# ${InvoiceApp.invoiceNo}'),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: cNameController,
                decoration: InputDecoration(
                  labelText: 'customer name',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Products',
                    style: TextStyle(fontSize: 22),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Product Info'),
                            content: SingleChildScrollView(
                              child: Column(
                                children: [
                                  TextField(
                                    controller: pNameController,
                                    decoration:
                                        InputDecoration(labelText: 'name'),
                                  ),
                                  TextField(
                                    controller: quantityController,
                                    decoration:
                                        InputDecoration(labelText: 'quantity'),
                                  ),
                                  TextField(
                                    controller: priceController,
                                    decoration:
                                        InputDecoration(labelText: 'price'),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    try {
                                      setState(() {
                                        products.add(Product(
                                            name: pNameController.text,
                                            quantity: int.parse(
                                                quantityController.text),
                                            price: double.parse(
                                                priceController.text)));
                                      });
                                      pNameController.clear();
                                      quantityController.clear();
                                      priceController.clear();
                                      Navigator.pop(context);
                                    } catch (e) {
                                      SnackBar snack = SnackBar(
                                          content: Text(
                                              'please fill all feilds correctly'));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snack);
                                    }
                                  },
                                  child: Text('add')),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('cancel')),
                            ],
                          ),
                        );
                      },
                      child: Text('add product')),
                ],
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      tileColor: Colors.blue[300],
                      leading: Text(
                        products[index].name,
                        style: TextStyle(fontSize: 22),
                      ),
                      title: Text('price ${products[index].price}'),
                      subtitle: Text('quantity ${products[index].quantity}'),
                      trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              products.removeAt(index);
                            });
                          },
                          icon: Icon(Icons.delete_forever)),
                    ),
                  );
                },
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        value.addInvoice(Invoice(
                            id: InvoiceApp.invoiceNo,
                            name: cNameController.text,
                            products: products));
                        InvoiceApp.invoiceNo++;
                        cNameController.clear();
                        products = [];
                        setState(() {});
                      },
                      child: Text('add invoice')),
                  ElevatedButton(
                      onPressed: () async {
                        await Navigator.pushNamed(context, '/invoices_list');
                        setState(() {});
                      },
                      child: Text('show all invoices')),
                ],
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        );
      },
    );
  }
}
