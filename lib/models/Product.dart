class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String shortDescription;
  final String longDescription;
  final String categoryId;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.shortDescription,
    required this.longDescription,
    required this.categoryId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      imageUrl: json['image_url'],
      shortDescription: json['short_description'],
      longDescription: json['long_description'],
      categoryId: json['category_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image_url': imageUrl,
      'short_description': shortDescription,
      'long_description': longDescription,
      'category_id': categoryId,
    };
  }
}
