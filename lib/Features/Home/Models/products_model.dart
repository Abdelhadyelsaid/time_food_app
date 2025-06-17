class AllProductsModel {
  AllProductsModel({
    required this.message,
    required this.count,
    required this.products,
  });

  final String? message;
  final num? count;
  final List<Product> products;

  factory AllProductsModel.fromJson(Map<String, dynamic> json){
    return AllProductsModel(
      message: json["message"],
      count: json["count"],
      products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    );
  }

}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.quantity,
    required this.image,
    required this.startDate,
    required this.expirationDate,
    required this.sendNotification,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? name;
  final num? quantity;
  final String? image;
  final DateTime? startDate;
  final DateTime? expirationDate;
  final bool? sendNotification;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id: json["_id"],
      name: json["name"],
      quantity: json["quantity"],
      image: json["image"],
      startDate: DateTime.tryParse(json["startDate"] ?? ""),
      expirationDate: DateTime.tryParse(json["expirationDate"] ?? ""),
      sendNotification: json["sendNotification"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}
