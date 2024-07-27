import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.account_circle, color: Colors.red),
                title: Text('Cuenta'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // Navegar a la página de cuenta
                },
              ),
              ListTile(
                leading: Icon(Icons.notifications, color: Colors.red),
                title: Text('Notificaciones'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // Navegar a la página de notificaciones
                },
              ),
              ListTile(
                leading: Icon(Icons.lock, color: Colors.red),
                title: Text('Privacidad'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // Navegar a la página de privacidad
                },
              ),
              ListTile(
                leading: Icon(Icons.help, color: Colors.red),
                title: Text('Ayuda'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // Navegar a la página de ayuda
                },
              ),
              ListTile(
                leading: Icon(Icons.info, color: Colors.red),
                title: Text('Acerca de'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // Navegar a la página de acerca de
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
