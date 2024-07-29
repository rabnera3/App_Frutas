import 'package:flutter/material.dart';
import '../helpers/DatabaseHelper.dart';
import '../models/Category.dart';

class CategoryProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  String _selectedCategoryId = '';
  List<Category> _categories = [];

  CategoryProvider() {
    _initBox();
  }

  Future<void> _initBox() async {
    await _dbHelper.database;
    await _loadCategories();
    notifyListeners();
  }

  Future<void> _loadCategories() async {
    final results = await _dbHelper.query('categories');
    _categories = results.map((result) {
      return Category(
        id: result['id'],
        name: result['name'],
        imageUrl: result['image_url'],
      );
    }).toList();
    notifyListeners();
  }

  String get selectedCategoryId => _selectedCategoryId;
  List<Category> get categories => _categories;

  void selectCategory(String categoryId) {
    if (_selectedCategoryId == categoryId) {
      _selectedCategoryId = ''; // Deseleccionar si ya está seleccionada
    } else {
      _selectedCategoryId = categoryId;
    }
    notifyListeners();
  }

  void clearCategory() {
    _selectedCategoryId = '';
    notifyListeners();
  }
}
