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

  Future<void> updateUser(Map<String, dynamic> fields) async {
    if (_user == null) return;

    // Construir la consulta SQL dinámicamente
    String sql = 'UPDATE users SET ';
    List<dynamic> values = [];

    fields.forEach((key, value) {
      sql += '$key = ?, ';
      values.add(value);
    });

    // Eliminar la última coma y espacio
    sql = sql.substring(0, sql.length - 2);
    sql += ' WHERE username = ?';
    values.add(_user!.username);

    await _dbHelper.execute(sql, values);

    // Actualizar el objeto _user con los nuevos valores
    fields.forEach((key, value) {
      switch (key) {
        case 'full_name':
          _user = _user!.copyWith(fullName: value);
          break;
        case 'address':
          _user = _user!.copyWith(address: value);
          break;
        case 'phone_number':
          _user = _user!.copyWith(phoneNumber: value);
          break;
        case 'gender':
          _user = _user!.copyWith(gender: value);
          break;
        case 'email':
          _user = _user!.copyWith(email: value);
          break;
        case 'password':
          _user = _user!.copyWith(password: value);
          break;
        // Agregar más campos según sea necesario
      }
    });

    notifyListeners();
  }

  Future<void> deleteUser() async {
    if (_user != null) {
      await _dbHelper.execute(
        'DELETE FROM users WHERE username = ?',
        [_user!.username],
      );
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

  Future<void> logout() async {
    _user = null;
    notifyListeners();
  }

  bool get isUserLoggedIn => _user != null;

  Future<bool> verifyPassword(String password) async {
    if (_user == null) return false;

    final results = await _dbHelper.rawQuery(
      'SELECT * FROM users WHERE username = ? AND password = ?',
      [_user!.username, password],
    );
    return results.isNotEmpty;
  }
}
