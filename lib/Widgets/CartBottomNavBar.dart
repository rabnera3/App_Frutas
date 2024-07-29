import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/CartProvider.dart';
import '../providers/OrdersProvider.dart'; // Asegúrate de tener el OrdersProvider
import '../models/Order.dart';

class CartBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);

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
            'Total: L${cart.totalAmount + 20}', // Incluyendo el costo de entrega
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _confirmOrder(context, cart, ordersProvider);
            },
            child: Text('Ordena Ahora'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _confirmOrder(
      BuildContext context, CartProvider cart, OrdersProvider ordersProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Orden'),
          content: Text('¿Desea ordenar estos productos?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _placeOrder(context, cart, ordersProvider);
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void _placeOrder(
      BuildContext context, CartProvider cart, OrdersProvider ordersProvider) {
    final user = ordersProvider.user;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Por favor, inicie sesión para realizar un pedido.')),
      );
      return;
    }

    final newOrder = Order(
      userId: user.id!,
      date: DateTime.now(),
      total: cart.totalAmount + 20,
      status: 'En camino',
    );

    ordersProvider.addOrder(newOrder);

    cart.clear(); // Limpiar el carrito después de realizar el pedido

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pedido realizado con éxito')),
    );
  }
}
