import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Pages/ItemPage.dart';
import '../models/Product.dart';
import '../providers/FavoriteProvider.dart';
import 'package:provider/provider.dart';


class ProductListWidget extends StatelessWidget {
  final String searchQuery;
  final String categoryId;

  ProductListWidget({
    required this.searchQuery,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    List<Product> filteredProducts = 
        .where((product) =>
            product.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    if (categoryId.isNotEmpty) {
      filteredProducts = filteredProducts
          .where((product) => product.categoryId == categoryId)
          .toList();
    }

    print(
        "Filtered Products: ${filteredProducts.length}"); // Agregado para depuración

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: filteredProducts.map((product) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemPage(product: product),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            product.imageUrl,
                            height: 100,
                            width: 100,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                product.name,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                product.longDescription,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5),
                              Text(
                                'L${product.price}',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Consumer<FavoriteProvider>(
                                builder: (context, favoriteProvider, _) {
                                  final isFavorite = favoriteProvider.favorites
                                      .contains(product);
                                  return IconButton(
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.red,
                                      size: 26,
                                    ),
                                    onPressed: () {
                                      if (isFavorite) {
                                        favoriteProvider
                                            .removeFavorite(product);
                                      } else {
                                        favoriteProvider.addFavorite(product);
                                      }
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
