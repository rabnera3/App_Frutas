import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Pages/ItemPage.dart';
import '../models/Product.dart';
import '../providers/FavoriteProvider.dart';
import 'package:provider/provider.dart';

class PopularItemsWidget extends StatelessWidget {
  final String searchQuery;

  PopularItemsWidget({required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    final products = [
      Product(
        id: 'p1',
        name: 'Aguacate',
        price: 10.0,
        imageUrl: 'images/aguacate.png',
        description: 'Delicioso aguacate.',
      ),
      Product(
        id: 'p2',
        name: 'Fresas',
        price: 5.0,
        imageUrl: 'images/fresa.png',
        description: 'Fresas frescas.',
      ),
      Product(
        id: 'p3',
        name: 'Bananas',
        price: 3.0,
        imageUrl: 'images/banana.png',
        description: 'Bananas dulces.',
      ),
      Product(
        id: 'p4',
        name: 'Tomate Pera',
        price: 1.0,
        imageUrl: 'images/tomate.png',
        description: 'Tomate para ensaladas.',
      ),
      Product(
        id: 'p5',
        name: 'Sandia Roja',
        price: 3.0,
        imageUrl: 'images/sandia.png',
        description: 'Sandia jugosa.',
      ),
    ];

    final filteredProducts = products
        .where((product) =>
            product.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: Row(
          children: filteredProducts.map((product) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 7),
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
                  width: 170,
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
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            product.imageUrl,
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          product.description,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'L${product.price}',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
                                      favoriteProvider.removeFavorite(product);
                                    } else {
                                      favoriteProvider.addFavorite(product);
                                    }
                                  },
                                );
                              },
                            ),
                          ],
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
