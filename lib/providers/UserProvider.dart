import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  late Box<User> _userBox;

  UserProvider() {
    _initBox();
  }

  Future<void> _initBox() async {
    _userBox = await Hive.openBox<User>('userBox');
    notifyListeners();
  }

  User? get user => _userBox.isNotEmpty ? _userBox.values.first : null;

  void updateUser(User user) {
    _userBox.put(user.username, user);
    notifyListeners();
  }

  void deleteUser() {
    _userBox.clear();
    notifyListeners();
  }

  bool get isUserLoggedIn => _userBox.isNotEmpty;
}
