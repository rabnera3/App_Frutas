import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi Cuenta"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Text("Aquí irán los detalles de la cuenta"),
      ),
    );
  }
}
