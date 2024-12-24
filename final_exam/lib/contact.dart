class Contact {
  int? id;
  String name;
  String number;
  Contact({this.id, required this.name, required this.number});

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "number": number};
  }
  

  factory Contact.fromJson(Map<String, dynamic> data) {
    return Contact(id: data["id"], name: data["name"], number: data["number"]);
  }
}
