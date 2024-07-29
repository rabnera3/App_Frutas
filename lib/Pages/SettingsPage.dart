import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/NotificationProvider.dart';
import '../Widgets/DrawerWidget.dart';
import '../Widgets/AppBarWidget.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  AppBarWidget(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Text(
                        'Configuración',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            AccountSection(),
                            NotificationsSection(),
                            HelpSection(),
                            AboutSection(),
                          ],
                        ),
                      ),
                    ),
                  ),
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

class AccountSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(Icons.account_circle, color: Colors.red),
      title: Text('Cuenta'),
      children: [
        ListTile(
          title: Text('Ir a mi cuenta'),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/account');
          },
        ),
      ],
    );
  }
}

class NotificationsSection extends StatefulWidget {
  @override
  _NotificationsSectionState createState() => _NotificationsSectionState();
}

class _NotificationsSectionState extends State<NotificationsSection> {
  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);

    bool _notificationsEnabled = notificationProvider.notificationsEnabled;
    bool _soundEnabled = notificationProvider.soundEnabled;
    bool _vibrationEnabled = notificationProvider.vibrationEnabled;

    return ExpansionTile(
      leading: Icon(Icons.notifications, color: Colors.red),
      title: Text('Notificaciones'),
      children: [
        SwitchListTile(
          title: Text('Activar Notificaciones'),
          value: _notificationsEnabled,
          onChanged: (bool value) {
            setState(() {
              _notificationsEnabled = value;
              notificationProvider.setNotificationSettings(
                notificationsEnabled: _notificationsEnabled,
                soundEnabled: _soundEnabled,
                vibrationEnabled: _vibrationEnabled,
              );
            });
          },
        ),
        if (_notificationsEnabled) ...[
          SwitchListTile(
            title: Text('Sonido'),
            value: _soundEnabled,
            onChanged: (bool value) {
              setState(() {
                _soundEnabled = value;
                notificationProvider.setNotificationSettings(
                  notificationsEnabled: _notificationsEnabled,
                  soundEnabled: _soundEnabled,
                  vibrationEnabled: _vibrationEnabled,
                );
              });
            },
          ),
          SwitchListTile(
            title: Text('Vibración'),
            value: _vibrationEnabled,
            onChanged: (bool value) {
              setState(() {
                _vibrationEnabled = value;
                notificationProvider.setNotificationSettings(
                  notificationsEnabled: _notificationsEnabled,
                  soundEnabled: _soundEnabled,
                  vibrationEnabled: _vibrationEnabled,
                );
              });
            },
          ),
        ],
      ],
    );
  }
}

class HelpSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(Icons.help, color: Colors.red),
      title: Text('Ayuda'),
      children: [
        ListTile(
          title: Text('Preguntas frecuentes'),
          onTap: () {
            _showPopup(context, 'Preguntas frecuentes',
                '1. ¿Cómo realizo un pedido?\nPara realizar un pedido, selecciona los productos que deseas comprar y agrégalos al carrito. Luego, procede al pago.\n\n2. ¿Cómo puedo rastrear mi pedido?\nUna vez que tu pedido ha sido enviado, puedes rastrear tu pedido en el apartado de pedidos en la app.\n\n3. ¿Puedo devolver un producto?\nSí, aceptamos devoluciones dentro de los 30 días posteriores a la compra. solamente si el pedido no llego en el tiempo acordado, o llego en mal estado.');
          },
        ),
        ListTile(
          title: Text('Contactar soporte'),
          onTap: () {
            _showPopup(context, 'Contactar soporte',
                'Si necesitas asistencia, puedes contactar a nuestro equipo de soporte técnico. Estamos disponibles las 24 horas del día, los 7 días de la semana para ayudarte con cualquier problema que puedas tener.');
          },
        ),
      ],
    );
  }
}

class AboutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(Icons.info, color: Colors.red),
      title: Text('Acerca de'),
      children: [
        ListTile(
          title: Text('Versión de la app'),
          onTap: () {
            _showPopup(context, 'Versión de la app',
                'Versión 1.0.0\nEsta es la primera versión de nuestra aplicación de compra de frutas. Estamos constantemente trabajando para mejorar y agregar nuevas funciones.');
          },
        ),
        ListTile(
          title: Text('Términos y condiciones'),
          onTap: () {
            _showPopup(context, 'Términos y condiciones',
                'Al usar esta aplicación, aceptas nuestros términos y condiciones. Nos reservamos el derecho de modificar estos términos en cualquier momento.');
          },
        ),
      ],
    );
  }
}

void _showPopup(BuildContext context, String title, String content) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                child: Text("Cerrar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
