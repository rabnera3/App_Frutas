import 'package:hive/hive.dart';
import 'Product.dart';

part 'CartItem.g.dart';

@HiveType(typeId: 1)
class CartItem extends HiveObject {
  @HiveField(0)
  final Product product;

  @HiveField(1)
  int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });
}
