import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Product.dart';
import '../providers/CartProvider.dart';
import '../providers/NotificationProvider.dart';
import '../models/Notification.dart';

class ItemBottomNavBar extends StatelessWidget {
  final Product product;
  final int quantity;

  ItemBottomNavBar({required this.product, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'L${product.price * quantity}',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final cart = Provider.of<CartProvider>(context, listen: false);
              final notifications =
                  Provider.of<NotificationProvider>(context, listen: false);

              for (int i = 0; i < quantity; i++) {
                cart.addItem(product);
              }

              notifications.addNotification(
                NotificationItem(
                  title: 'Producto añadido',
                  message: '${product.name} añadido al carrito.',
                  onTap: (context) {
                    Navigator.pushNamed(context, 'cartPage');
                  },
                ),
              );
            },
            child: Text('Añadir al carrito'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
