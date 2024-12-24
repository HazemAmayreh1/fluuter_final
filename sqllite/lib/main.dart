import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqllite/database_provider.dart';
import 'package:sqllite/details_page.dart';
import 'package:sqllite/product.dart';


void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Products',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
        useMaterial3: true,
      ),
      home: MainPage(),
      
    );
  }
}
class MainPage extends StatefulWidget {

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController productControllerName = TextEditingController();
  final TextEditingController productControllerQuintity = TextEditingController();
  final TextEditingController productControllerPrice = TextEditingController();

 int updateId = 0;

  void _showDialog(BuildContext context, String type) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        type == 'add' ? "Add Product" : "Update Product",
        style: const TextStyle(fontSize: 20),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: productControllerName,
              decoration: const InputDecoration(
                label: Text("Product Name"),
                hintText: "Enter Product Name",
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: productControllerQuintity,
              decoration: const InputDecoration(
                label: Text("Product Quantity"),
                hintText: "Enter Product Quantity",
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: productControllerPrice,
              decoration: const InputDecoration(
                label: Text("Product Price"),
                hintText: "Enter Product Price",
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (type == 'add') {
              setState(() {
                Product productNew = Product(
                  name: productControllerName.text,
                  price: double.parse(productControllerPrice.text),
                  quantity: int.parse(productControllerQuintity.text),
                );
                DatabaseProvider.db.insertProduct(productNew).then((value){
                  SnackBar snackBar = SnackBar(content: Text('${productNew.name} add at rowid $value '));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
                productControllerName.clear();
                productControllerPrice.clear();
                productControllerQuintity.clear();
                Navigator.of(context).pop();
              });
            } else {
              DatabaseProvider.db.getProduct(updateId).then((value){
              productControllerName.text=value.name;
              productControllerPrice.text=value.price.toString();
              productControllerQuintity.text=value.quantity.toString();
              });
             
              Product P = Product (
                id:updateId,
              name:productControllerName.text,
              quantity: int.parse(productControllerQuintity.text),
              price:double.parse(productControllerPrice.text), 
              );
              DatabaseProvider.db.updateProduct(P).then((value){
                SnackBar snackBar = SnackBar(content: Text('${P.name} updated at rowid $value '));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }).catchError((onError){
                SnackBar snackBar = SnackBar(content: onError);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });

            }
            setState(() {
              
            });
            Navigator.of(context).pop();
          },
          child: Text(type == 'add' ? 'Add' : 'Update'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products App'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Products:', style: TextStyle(fontSize: 24)),
              ElevatedButton(
                onPressed: () {
                  _showDialog(context,'add');
                },
                child: Text('add product'),
               
              ),
            ],
          ),
          FutureBuilder(
            future: DatabaseProvider.db.getAllProducts(), 
            builder: (context,snapshot){
              if(snapshot.hasData){
                List<Product>? products = snapshot.data;
                if(products!.isEmpty)
                  return Text('no product found',style: TextStyle(fontSize: 24),);
                  else{
                    return Expanded(
                      child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder:(context, index) =>
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage(products[index].id!),));
                            },
                            onLongPress:(){
                           updateId = products[index].id!;
                              _showDialog(context,'update');
                             
                            } ,
                            tileColor: Colors.blue,
                            leading: Text(products[index].name,style: TextStyle(fontSize: 24),),
                            title: Text('quantity:${products[index].quantity}' ),
                            subtitle:Text('price:${products[index].price}' ), 
                            trailing: IconButton(
                              onPressed: (){
                                setState(() {
                                      DatabaseProvider.db.removeProduct(products[index]).then((value){
                                      if(value !=0){
                                    SnackBar snackBar = SnackBar(content: Text('${products[index].name} '));
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }
                                  });
                             });
                              }, 
                              icon: Icon(Icons.delete)
                              ) ,
                                                
                          ),
                        ) , 
                      ),
                    );
                  }
              } else if (snapshot.hasError){
                 return Text('error ${snapshot.error}',style: TextStyle(fontSize: 24),);
              }
              else{
                return CircularProgressIndicator();
              }

              
            },
            )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DatabaseProvider.db.removeAll().then((value){
            SnackBar snackBar = SnackBar(content: Text('$value products deleted '));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
          setState(() {
            
          });
        },
        child: Icon(Icons.delete_sweep),
        tooltip: 'delete all product',
      ),
    );
  }
}