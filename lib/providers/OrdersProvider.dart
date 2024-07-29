import 'package:flutter/material.dart';
import '../helpers/DatabaseHelper.dart';
import '../models/Order.dart';
import '../models/User.dart';
import 'UserProvider.dart'; // Importamos el UserProvider

class OrdersProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Order> _orders = [];
  UserProvider? _userProvider; // Referencia al UserProvider

  OrdersProvider() {
    _initOrders();
  }

  void setUserProvider(UserProvider userProvider) {
    _userProvider = userProvider;
    _loadOrders();
  }

  User? get user => _userProvider?.user; // Getter para el usuario

  Future<void> _initOrders() async {
    await _dbHelper.database;
    await _loadOrders();
  }

  Future<void> _loadOrders() async {
    if (_userProvider == null || _userProvider!.user == null) return;

    final results = await _dbHelper.rawQuery(
      'SELECT * FROM orders WHERE user_id = ?',
      [_userProvider!.user!.id],
    );

    _orders = results.map((result) {
      return Order.fromJson(result);
    }).toList();
    notifyListeners();
  }

  List<Order> get orders => _orders;

  Future<void> addOrder(Order order) async {
    if (_userProvider == null || _userProvider!.user == null) return;

    final orderId = await _dbHelper.insert('orders', {
      'user_id': _userProvider!.user!.id,
      'date': order.date.toIso8601String(),
      'total': order.total,
      'status': order.status,
    });

    _orders.add(order.copyWith(id: orderId));
    notifyListeners();
  }

  Future<void> removeOrder(Order order) async {
    if (_userProvider == null || _userProvider!.user == null) return;

    await _dbHelper.delete(
      'orders',
      'id = ? AND user_id = ?',
      [order.id, _userProvider!.user!.id],
    );
    _orders.removeWhere((item) => item.id == order.id);
    notifyListeners();
  }
}
