import 'package:flutter/material.dart';
import '../Widgets/DrawerWidget.dart';
import '../Widgets/AppBarWidget.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBarWidget(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  'Mis Pedidos',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(16.0),
                children: [
                  OrderItem(
                    orderId: '123456',
                    date: '2024-07-24',
                    total: 50.0,
                    status: 'En camino',
                  ),
                  OrderItem(
                    orderId: '789012',
                    date: '2024-07-23',
                    total: 30.0,
                    status: 'Entregado',
                  ),
                  // Agrega más OrderItem según sea necesario
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: DrawerWidget(),
    );
  }
}

class OrderItem extends StatelessWidget {
  final String orderId;
  final String date;
  final double total;
  final String status;

  OrderItem({
    required this.orderId,
    required this.date,
    required this.total,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.receipt, color: Colors.red, size: 30),
                SizedBox(width: 10),
                Text(
                  'Pedido #$orderId',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: status == 'En camino' ? Colors.orange : Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            Divider(height: 20, thickness: 1),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.red),
                SizedBox(width: 10),
                Text('Fecha: $date'),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.attach_money, color: Colors.red),
                SizedBox(width: 10),
                Text('Total: L$total'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
