import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CategoryProvider with ChangeNotifier {
  late Box<String> _categoryBox;

  CategoryProvider() {
    _initBox();
  }

  Future<void> _initBox() async {
    _categoryBox = await Hive.openBox<String>('categoryBox');
    notifyListeners();
  }

  String get selectedCategoryId =>
      _categoryBox.get('selectedCategoryId', defaultValue: '') ?? '';

  void selectCategory(String categoryId) {
    _categoryBox.put('selectedCategoryId', categoryId);
    notifyListeners();
  }

  void clearCategory() {
    _categoryBox.delete('selectedCategoryId');
    notifyListeners();
  }
}
