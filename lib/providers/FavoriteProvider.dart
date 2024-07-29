import 'package:flutter/material.dart';
import '../helpers/DatabaseHelper.dart';
import '../models/Product.dart';
import '../models/User.dart';

class FavoriteProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Product> _favoriteProducts = [];
  User? _user;

  FavoriteProvider() {
    _initFavorites();
  }

  void setUser(User? user) {
    _user = user;
    _loadFavorites();
  }

  Future<void> _initFavorites() async {
    await _dbHelper.database;
  }

  Future<void> _loadFavorites() async {
    if (_user == null) return;

    final results = await _dbHelper.rawQuery(
      'SELECT products.* FROM favorites JOIN products ON favorites.product_id = products.id WHERE favorites.user_id = ?',
      [_user!.id],
    );

    _favoriteProducts = results.map((result) {
      return Product.fromJson(result);
    }).toList();
    notifyListeners();
  }

  List<Product> get favoriteProducts => _favoriteProducts;

  Future<void> addFavorite(Product product) async {
    if (_user == null) return;

    await _dbHelper.insert('favorites', {
      'user_id': _user!.id,
      'product_id': product.id,
    });
    _favoriteProducts.add(product);
    notifyListeners();
  }

  Future<void> removeFavorite(Product product) async {
    if (_user == null) return;

    await _dbHelper.delete(
      'favorites',
      'user_id = ? AND product_id = ?',
      [_user!.id, product.id],
    );
    _favoriteProducts.removeWhere((item) => item.id == product.id);
    notifyListeners();
  }
}
