import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/Product.dart';
import '../models/CartItem.dart';

class CartProvider with ChangeNotifier {
  late Box<CartItem> _cartBox;

  CartProvider() {
    _initBox();
  }

  Future<void> _initBox() async {
    _cartBox = await Hive.openBox<CartItem>('cartBox');
    notifyListeners();
  }

  Map<String, CartItem> get items {
    Map<String, CartItem> itemsMap = {};
    for (var item in _cartBox.values) {
      itemsMap[item.product.id] = item;
    }
    return itemsMap;
  }

  int get itemCount => _cartBox.length;

  double get totalAmount {
    double total = 0.0;
    for (var cartItem in _cartBox.values) {
      total += cartItem.product.price * cartItem.quantity;
    }
    return total;
  }

  void addItem(Product product) {
    if (_cartBox.containsKey(product.id)) {
      CartItem existingCartItem = _cartBox.get(product.id)!;
      existingCartItem.quantity += 1;
      _cartBox.put(product.id, existingCartItem);
    } else {
      _cartBox.put(
        product.id,
        CartItem(product: product, quantity: 1),
      );
    }
    notifyListeners();
  }

  void removeItem(Product product) {
    if (!_cartBox.containsKey(product.id)) return;
    CartItem existingCartItem = _cartBox.get(product.id)!;
    if (existingCartItem.quantity > 1) {
      existingCartItem.quantity -= 1;
      _cartBox.put(product.id, existingCartItem);
    } else {
      _cartBox.delete(product.id);
    }
    notifyListeners();
  }

  int getItemQuantity(String productId) {
    return _cartBox.containsKey(productId)
        ? _cartBox.get(productId)!.quantity
        : 0;
  }

  void clear() {
    _cartBox.clear();
    notifyListeners();
  }
}
