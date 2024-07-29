import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/OrdersProvider.dart';
import '../Widgets/DrawerWidget.dart';
import '../Widgets/AppBarWidget.dart';
import '../models/Order.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final orders = ordersProvider.orders;

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
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(16.0),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return OrderItem(
                    orderId: order.id.toString(),
                    date: order.date.toString().split(' ')[0],
                    total: order.total,
                    status: order.status,
                  );
                },
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
