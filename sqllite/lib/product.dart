class Product {
  int? id;
  String name;
  int quantity;
  double price;
  Product({
    this.id,
    required this.name,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      id: data['id'],
      name:data['name'],
      quantity: data['quantity'],
      price: data['price'],
    );
  }

  @override
  String toString() {
    return 'id: $id\nname: $name\nquantity: $quantity\nprice: $price';
  }
}