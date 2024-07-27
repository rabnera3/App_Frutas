import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis Pedidos"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Text("Aquí irán los detalles de los pedidos"),
      ),
    );
  }
}
