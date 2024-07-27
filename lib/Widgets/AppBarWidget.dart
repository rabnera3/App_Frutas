import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/NotificationProvider.dart';
import '../providers/FavoriteProvider.dart'; // Nueva importación
import '../Pages/FavoritesPage.dart'; // Nueva importación
import 'NotificationMenu.dart';

class AppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        InkWell(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: Icon(CupertinoIcons.bars),
          ),
        ),
        Row(
          children: [
            Stack(
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => NotificationMenu(),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    child: Icon(Icons.notifications),
                  ),
                ),
                if (notificationProvider.notificationCount > 0)
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        notificationProvider.notificationCount.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 15),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritesPage()),
                );
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Icon(Icons.favorite),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
