import 'package:flutter/material.dart';
import '../models/category_data.dart';
import '../models/Category.dart';

class CategoriesWidget extends StatelessWidget {
  final Function(String, String) onCategorySelected;
  final String selectedCategoryId;

  CategoriesWidget(
      {required this.onCategorySelected, required this.selectedCategoryId});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: Row(
          children: categories.map((Category category) {
            final isSelected = category.id == selectedCategoryId;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () => onCategorySelected(category.id, category.name),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.red : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    category.imageUrl,
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
