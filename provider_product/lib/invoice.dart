import 'product.dart';

class Invoice {
  int id;
  String name;
  List<Product> products;
  Invoice({
    required this.id,
    required this.name,
    required this.products,
  });

  factory Invoice.fromJson(dynamic json) {
    return Invoice(
      id: int.parse(json['invoiceNo']),
      name: json['customerName'],
      products:
          (json['products'] as List).map((e) => Product.fromJson(e)).toList(),
    );
  }
  @override
  String toString() {
    int totalQ = 0;
    double totalP = 0;
    String res = "";
    for (int i = 0; i < products.length; i++) {
      res += '${i + 1} - ${products[i].toString()}\n';
      totalQ += products[i].quantity;
      totalP += products[i].quantity * products[i].price;
    }
    res += '''


Total quantity: $totalQ
Total Price: $totalP
            ''';
    return res;
  }
}
