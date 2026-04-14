class Product {
  final int id;
  final String title;
  final double price;
  final String description;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
    );
  }
}