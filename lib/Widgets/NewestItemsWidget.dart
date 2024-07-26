import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../Pages/ItemPage.dart';
import '../models/Product.dart';

class NewestItemsWidget extends StatelessWidget {
  final String searchQuery;

  NewestItemsWidget({required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    final products = [
      Product(
        id: 'p5',
        name: 'Sandia Roja',
        price: 3.0,
        imageUrl: 'images/sandia.png',
        description:
            'Prueba el increible sabor de nuestra Sandia Roja, jugosa y refrescante.',
      ),
      Product(
        id: 'p1',
        name: 'Aguacate Maduro',
        price: 2.0,
        imageUrl: 'images/aguacate.png',
        description:
            'Aguacate 100% Mexicano, perfecto para guacamole y ensaladas.',
      ),
      Product(
        id: 'p3',
        name: 'Bananas',
        price: 3.0,
        imageUrl: 'images/banana.png',
        description: 'Bananas Cavendish, dulces y ricas en potasio.',
      ),
      Product(
        id: 'p4',
        name: 'Tomate Pera',
        price: 1.0,
        imageUrl: 'images/tomate.png',
        description: 'Tomates Pera, ideales para ensaladas y salsas.',
      ),
      Product(
        id: 'p2',
        name: 'Fresa Suave',
        price: 5.0,
        imageUrl: 'images/fresa.png',
        description: 'Fresas suaves, perfectas para tus postres y batidos.',
      ),
    ];

    final filteredProducts = products
        .where((product) =>
            product.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

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
                  width: 380,
                  height: 170,
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
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          product.imageUrl,
                          height: 140,
                          width: 150,
                        ),
                      ),
                      Container(
                        width: 190,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              product.description,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            RatingBar.builder(
                              initialRating: 4,
                              minRating: 1,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemSize: 18,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.red,
                              ),
                              onRatingUpdate: (index) {},
                            ),
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
                            Icon(
                              Icons.favorite_border,
                              color: Colors.red,
                              size: 26,
                            ),
                            Icon(
                              CupertinoIcons.cart,
                              color: Colors.red,
                              size: 26,
                            ),
                          ],
                        ),
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
