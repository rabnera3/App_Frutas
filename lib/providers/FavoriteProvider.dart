import 'package:flutter/material.dart';
import '../helpers/DatabaseHelper.dart';
import '../models/Favorite.dart';
import '../models/Product.dart';

class FavoriteProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Favorite> _favorites = [];
  List<Product> _favoriteProducts = [];
  int _userId = 0; // Campo para almacenar el userId

  FavoriteProvider() {
    _initBox();
  }

  Future<void> _initBox() async {
    await _dbHelper.database;
    if (_userId != 0) {
      await _loadFavorites();
    }
  }

  Future<void> _loadFavorites() async {
    final results = await _dbHelper.rawQuery(
      'SELECT favorites.id, favorites.user_id, favorites.product_id, '
      'products.name, products.price, products.image_url, products.short_description, products.long_description, products.category_id '
      'FROM favorites '
      'JOIN products ON favorites.product_id = products.id '
      'WHERE favorites.user_id = ?',
      [_userId],
    );

    _favorites = results.map((result) {
      return Favorite(
        id: result['id'],
        userId: result['user_id'],
        productId: result['product_id'].toString(),
      );
    }).toList();

    _favoriteProducts = results.map((result) {
      return Product(
        id: result['product_id'].toString(),
        name: result['name'],
        price: result['price'],
        imageUrl: result['image_url'],
        shortDescription: result['short_description'],
        longDescription: result['long_description'],
        categoryId: result['category_id'].toString(),
      );
    }).toList();
    notifyListeners();
  }

  List<Product> get favoriteProducts => _favoriteProducts;
  int get userId => _userId; // Agregar un getter para userId

  Future<void> addFavorite(Product product) async {
    final existing = _favorites.firstWhere(
      (favorite) => favorite.productId == product.id,
      orElse: () => Favorite(id: 0, userId: 0, productId: ''),
    );

    if (existing.id == 0) {
      await _dbHelper.execute(
        'INSERT INTO favorites (user_id, product_id) VALUES (?, ?)',
        [_userId, product.id],
      );
      // Obtener el ID del último insertado
      var result = await _dbHelper
          .rawQuery('SELECT id FROM favorites ORDER BY id DESC LIMIT 1');
      var insertId = result.first['id'];

      _favorites
          .add(Favorite(id: insertId, userId: _userId, productId: product.id));
      _favoriteProducts.add(product);
      notifyListeners();
    }
  }

  Future<void> removeFavorite(Product product) async {
    await _dbHelper.execute(
      'DELETE FROM favorites WHERE user_id = ? AND product_id = ?',
      [_userId, product.id],
    );
    _favorites.removeWhere((favorite) => favorite.productId == product.id);
    _favoriteProducts
        .removeWhere((favoriteProduct) => favoriteProduct.id == product.id);
    notifyListeners();
  }

  // Método para establecer el userId y cargar favoritos
  void setUserId(int userId) {
    _userId = userId;
    _loadFavorites();
  }
}
