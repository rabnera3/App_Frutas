import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../Pages/ItemPage.dart';
import '../models/Product.dart';
import 'package:provider/provider.dart';
import '../providers/FavoriteProvider.dart';
import '../providers/CartProvider.dart';
import '../providers/NotificationProvider.dart';
import '../models/Notification.dart';
import '../models/product_data.dart';

class NewestItemsWidget extends StatelessWidget {
  final String searchQuery;
  final String categoryId;

  NewestItemsWidget({required this.searchQuery, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    List<Product> filteredProducts = products
        .where((product) =>
            product.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    if (categoryId.isNotEmpty) {
      filteredProducts = filteredProducts
          .where((product) => product.categoryId == categoryId)
          .toList();
    }

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
                                product.description,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5),
                              RatingBar.builder(
                                initialRating: 4,
                                minRating: 1,
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemSize: 18,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.red,
                                ),
                                onRatingUpdate: (index) {},
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
                              IconButton(
                                icon: Icon(
                                  CupertinoIcons.cart,
                                  color: Colors.red,
                                  size: 26,
                                ),
                                onPressed: () {
                                  final cart = Provider.of<CartProvider>(
                                      context,
                                      listen: false);
                                  cart.addItem(product);

                                  // Agregar notificación
                                  final notificationProvider =
                                      Provider.of<NotificationProvider>(context,
                                          listen: false);
                                  notificationProvider
                                      .addNotification(NotificationItem(
                                    title: 'Producto Añadido',
                                    message:
                                        'Añadido al carrito: ${product.name}',
                                    onTap: (context) {
                                      Navigator.pushNamed(context, 'cartPage');
                                    },
                                  ));
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
