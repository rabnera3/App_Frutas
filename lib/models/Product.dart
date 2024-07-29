import 'package:hive/hive.dart';

part 'Product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String imageUrl;

  @HiveField(4)
  final String shortDescription;

  @HiveField(5)
  final String longDescription;

  @HiveField(6)
  final String categoryId;

  @HiveField(7)
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.shortDescription,
    required this.longDescription,
    required this.categoryId,
    required this.category,
  });
}
