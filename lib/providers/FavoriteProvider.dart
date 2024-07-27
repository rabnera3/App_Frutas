import 'package:flutter/material.dart';
import '../models/Product.dart';

class FavoriteProvider with ChangeNotifier {
  final List<Product> _favorites = [];

  List<Product> get favorites => _favorites;

  void addFavorite(Product product) {
    if (!_favorites.contains(product)) {
      _favorites.add(product);
      notifyListeners();
    }
  }

  void removeFavorite(Product product) {
    if (_favorites.contains(product)) {
      _favorites.remove(product);
      notifyListeners();
    }
  }
}
