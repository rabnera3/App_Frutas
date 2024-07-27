// Product.dart
class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final String categoryId; // Nuevo atributo
  final String category; // Nuevo atributo

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.categoryId, // Nuevo atributo
    required this.category, // Nuevo atributo
  });
}
