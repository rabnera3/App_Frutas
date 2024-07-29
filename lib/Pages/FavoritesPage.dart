import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/FavoriteProvider.dart';
import 'ItemPage.dart';
import '../Widgets/AppBarWidget.dart';
import '../Widgets/DrawerWidget.dart';
import '../providers/UserProvider.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    // Asegúrate de que el usuario esté autenticado
    if (userProvider.user == null) {
      return Center(child: Text('Usuario no autenticado.'));
    }

    return Scaffold(
      drawer: DrawerWidget(),
      body: ListView(
        children: [
          AppBarWidget(),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Favoritos',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (favoriteProvider.favoriteProducts.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'No tienes productos en tus favoritos.',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )
          else
            ...favoriteProvider.favoriteProducts.map((product) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                                IconButton(
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 26,
                                  ),
                                  onPressed: () {
                                    favoriteProvider.removeFavorite(product);
                                  },
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
                ),
              );
            }).toList(),
        ],
      ),
    );
  }
}
