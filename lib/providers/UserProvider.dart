import 'package:flutter/material.dart';
import '../helpers/DatabaseHelper.dart';
import '../models/User.dart';

class UserProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  User? _user;

  UserProvider() {
    _initUser();
  }

  Future<void> _initUser() async {
    await _dbHelper.database;
    await _loadUser();
  }

  Future<void> _loadUser() async {
    final results = await _dbHelper.rawQuery('SELECT * FROM users LIMIT 1');
    if (results.isNotEmpty) {
      _user = User.fromJson(results.first);
    }
    notifyListeners();
  }

  User? get user => _user;

  Future<void> updateUser(User user) async {
    await _dbHelper.execute(
      'UPDATE users SET full_name = ?, address = ?, phone_number = ?, birth_date = ?, gender = ?, email = ?, password = ?, updated_at = ? WHERE username = ?',
      [
        user.fullName,
        user.address,
        user.phoneNumber,
        user.birthDate.toIso8601String(),
        user.gender,
        user.email,
        user.password,
        DateTime.now().toIso8601String(), // Actualización manual de updated_at
        user.username,
      ],
    );
    _user = user;
    notifyListeners();
  }

  Future<void> deleteUser() async {
    if (_user != null) {
      await _dbHelper
          .execute('DELETE FROM users WHERE username = ?', [_user!.username]);
      _user = null;
      notifyListeners();
    }
  }

  Future<bool> login(String username, String password) async {
    final results = await _dbHelper.rawQuery(
      'SELECT * FROM users WHERE username = ? AND password = ?',
      [username, password],
    );
    if (results.isNotEmpty) {
      _user = User.fromJson(results.first);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> register(User user) async {
    final existingUser = await _dbHelper.rawQuery(
      'SELECT * FROM users WHERE username = ? OR email = ?',
      [user.username, user.email],
    );
    if (existingUser.isNotEmpty) {
      return false; // Usuario ya existe
    }
    await _dbHelper.execute(
      'INSERT INTO users (username, full_name, address, phone_number, birth_date, gender, email, password, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
      [
        user.username,
        user.fullName,
        user.address,
        user.phoneNumber,
        user.birthDate.toIso8601String(),
        user.gender,
        user.email,
        user.password,
        user.createdAt.toIso8601String(),
        user.updatedAt.toIso8601String(),
      ],
    );
    _user = user;
    notifyListeners();
    return true; // Registro exitoso
  }

  bool get isUserLoggedIn => _user != null;
}
