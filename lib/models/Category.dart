import 'package:hive/hive.dart';

part 'Category.g.dart';

@HiveType(typeId: 0)
class Category extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String imageUrl;

  Category({required this.id, required this.name, required this.imageUrl});
}
