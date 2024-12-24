class Product {
  String name;
  int quantity;
  double price;
  Product({
    required this.name,
    required this.quantity,
    required this.price,
  });
  factory Product.fromJson(dynamic jsonObject) {
    return Product(
        name: jsonObject['productName'],
        quantity: int.parse(jsonObject['quantity']),
        price: double.parse(jsonObject['price']));
  }
  @override
  String toString() => '$name, quantity: $quantity, price: $price';
}
