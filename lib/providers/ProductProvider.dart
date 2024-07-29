import 'package:flutter/foundation.dart';
import '../helpers/DatabaseHelper.dart';
import '../models/Product.dart';

class ProductProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Product> _products = [];

  ProductProvider() {
    _init();
  }

  Future<void> _init() async {
    await _dbHelper.database;
    await _loadProducts();
  }

  Future<void> _loadProducts() async {
    final results = await _dbHelper.query('products');
    _products = results.map((result) {
      return Product.fromJson(result);
    }).toList();
    notifyListeners();
  }

  List<Product> get products => _products;

  Product getProductById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }
}
