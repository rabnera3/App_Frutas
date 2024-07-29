import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Category.dart';
import '../providers/CategoryProvider.dart';

class CategoriesWidget extends StatelessWidget {
  final Function(String, String) onCategorySelected;

  CategoriesWidget({required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: Row(
          children: categoryProvider.categories.map((Category category) {
            final isSelected =
                category.id == categoryProvider.selectedCategoryId;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () {
                  categoryProvider.selectCategory(category.id);
                  onCategorySelected(category.id, category.name);
                },
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
                  child: Column(
                    children: [
                      Image.asset(
                        '${category.imageUrl}', // Ajuste aquí
                        width: 50,
                        height: 50,
                      ),
                    ],
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
