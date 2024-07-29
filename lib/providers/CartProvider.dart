import 'package:flutter/material.dart';
import '../models/Product.dart';
import '../models/CartItem.dart';
import '../helpers/DatabaseHelper.dart';

class CartProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  Map<String, CartItem> _items = {};
  Map<String, Product> _productMap = {}; // Mapa de productos cargados

  CartProvider() {
    _initBox();
  }

  Future<void> _initBox() async {
    await _dbHelper.database;
    await _loadCartItems();
    await _loadProducts(); // Cargar productos
    notifyListeners();
  }

  Future<void> _loadCartItems() async {
    var results = await _dbHelper.query('cart_items');
    for (var row in results) {
      _items[row['product_id']] = CartItem(
        id: row['id'],
        userId: row['user_id'],
        productId: row['product_id'].toString(),
        quantity: row['quantity'],
      );
    }
  }

  Future<void> _loadProducts() async {
    var results = await _dbHelper.query('products');
    for (var row in results) {
      _productMap[row['id'].toString()] = Product(
        id: row['id'].toString(),
        name: row['name'],
        price: row['price'],
        imageUrl: row['image_url'],
        shortDescription: row['short_description'],
        longDescription: row['long_description'],
        categoryId: row['category_id'],
      );
    }
  }

  Map<String, CartItem> get items => _items;

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      // Se debe obtener el producto correspondiente del mapa de productos
      Product product = getProductById(cartItem.productId);
      total += cartItem.quantity * product.price;
    });
    return total;
  }

  Future<void> addItem(Product product, int userId) async {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          userId: existingCartItem.userId,
          productId: existingCartItem.productId,
          quantity: existingCartItem.quantity + 1,
        ),
      );
      await _dbHelper.execute(
        'UPDATE cart_items SET quantity = quantity + 1 WHERE product_id = ?',
        [product.id],
      );
    } else {
      await _dbHelper.execute(
        'INSERT INTO cart_items (user_id, product_id, quantity) VALUES (?, ?, ?)',
        [userId, product.id, 1],
      );

      // Obtener el ID del último insertado
      var result = await _dbHelper.rawQuery(
          'SELECT id FROM cart_items WHERE user_id = ? ORDER BY id DESC LIMIT 1',
          [userId]);
      var insertId = result.first['id'];

      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: insertId,
          userId: userId,
          productId: product.id,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  Future<void> removeItem(Product product) async {
    if (!_items.containsKey(product.id)) return;

    if (_items[product.id]!.quantity > 1) {
      _items.update(
        product.id,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          userId: existingCartItem.userId,
          productId: existingCartItem.productId,
          quantity: existingCartItem.quantity - 1,
        ),
      );
      await _dbHelper.execute(
        'UPDATE cart_items SET quantity = quantity - 1 WHERE product_id = ?',
        [product.id],
      );
    } else {
      _items.remove(product.id);
      await _dbHelper.execute(
        'DELETE FROM cart_items WHERE product_id = ?',
        [product.id],
      );
    }
    notifyListeners();
  }

  Future<void> clear() async {
    _items.clear();
    await _dbHelper.execute('DELETE FROM cart_items');
    notifyListeners();
  }

  int getItemQuantity(String productId) {
    return _items.containsKey(productId) ? _items[productId]!.quantity : 0;
  }

  Product getProductById(String productId) {
    if (_productMap.containsKey(productId)) {
      return _productMap[productId]!;
    } else {
      throw Exception('Producto no encontrado');
    }
  }
}
