import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../Pages/ItemPage.dart';
import '../models/Product.dart';
import 'package:provider/provider.dart';
import '../providers/CartProvider.dart';
import '../providers/NotificationProvider.dart';
import '../providers/ProductProvider.dart';
import '../providers/UserProvider.dart';
import '../providers/FavoriteProvider.dart';
import '../models/Notification.dart';

class NewestItemsWidget extends StatelessWidget {
  final String searchQuery;
  final String categoryId;

  NewestItemsWidget({required this.searchQuery, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final user = userProvider.user;

    List<Product> products = productProvider.products;

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
            final isFavorite = favoriteProvider.favoriteProducts
                .any((p) => p.id == product.id);

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
                                product.shortDescription,
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
                              IconButton(
                                icon: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red,
                                  size: 26,
                                ),
                                onPressed: () {
                                  if (user != null) {
                                    if (isFavorite) {
                                      favoriteProvider.removeFavorite(product);
                                    } else {
                                      favoriteProvider.addFavorite(product);
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Por favor, inicia sesión para gestionar favoritos')),
                                    );
                                  }
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  CupertinoIcons.cart,
                                  color: Colors.red,
                                  size: 26,
                                ),
                                onPressed: () {
                                  if (user != null) {
                                    final cart = Provider.of<CartProvider>(
                                        context,
                                        listen: false);
                                    cart.addItem(product, user.id!);

                                    // Agregar notificación
                                    final notificationProvider =
                                        Provider.of<NotificationProvider>(
                                            context,
                                            listen: false);
                                    notificationProvider.addNotification(
                                      NotificationItem(
                                        userId: user.id!,
                                        title: 'Producto Añadido',
                                        message:
                                            'Añadido al carrito: ${product.name}',
                                        dateTime: DateTime.now(),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Por favor, inicia sesión para añadir al carrito')),
                                    );
                                  }
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
