// CategoryProvider.dart
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  String _selectedCategoryId = '';

  String get selectedCategoryId => _selectedCategoryId;

  void selectCategory(String categoryId) {
    _selectedCategoryId = categoryId;
    notifyListeners();
  }

  void clearCategory() {
    _selectedCategoryId = '';
    notifyListeners();
  }
}
