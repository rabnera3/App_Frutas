import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/Product.dart';

class FavoriteProvider with ChangeNotifier {
  late Box<Product> _favoritesBox;

  FavoriteProvider() {
    _initBox();
  }

  Future<void> _initBox() async {
    _favoritesBox = await Hive.openBox<Product>('favoritesBox');
    notifyListeners();
  }

  List<Product> get favorites => _favoritesBox.values.toList();

  void addFavorite(Product product) {
    if (!_favoritesBox.containsKey(product.id)) {
      _favoritesBox.put(product.id, product);
      notifyListeners();
    }
  }

  void removeFavorite(Product product) {
    if (_favoritesBox.containsKey(product.id)) {
      _favoritesBox.delete(product.id);
      notifyListeners();
    }
  }
}
