import 'package:hive/hive.dart';
import 'CartItem.dart';

part 'cart.g.dart';

@HiveType(typeId: 5)
class Cart extends HiveObject {
  @HiveField(0)
  List<CartItem> items = [];
}
