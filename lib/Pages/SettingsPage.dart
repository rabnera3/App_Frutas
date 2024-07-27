import 'package:flutter/material.dart';

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
                            PrivacySection(),
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
          title: Text('Perfil'),
          onTap: () {
            // Navegar a la página de perfil
          },
        ),
        ListTile(
          title: Text('Seguridad'),
          onTap: () {
            // Navegar a la página de seguridad
          },
        ),
      ],
    );
  }
}

class NotificationsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(Icons.notifications, color: Colors.red),
      title: Text('Notificaciones'),
      children: [
        ListTile(
          title: Text('Sonido'),
          onTap: () {
            // Navegar a la página de sonido
          },
        ),
        ListTile(
          title: Text('Vibración'),
          onTap: () {
            // Navegar a la página de vibración
          },
        ),
      ],
    );
  }
}

class PrivacySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(Icons.lock, color: Colors.red),
      title: Text('Privacidad'),
      children: [
        ListTile(
          title: Text('Contraseña'),
          onTap: () {
            // Navegar a la página de contraseña
          },
        ),
        ListTile(
          title: Text('Autenticación de dos factores'),
          onTap: () {
            // Navegar a la página de autenticación de dos factores
          },
        ),
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
            // Navegar a la página de preguntas frecuentes
          },
        ),
        ListTile(
          title: Text('Contactar soporte'),
          onTap: () {
            // Navegar a la página de soporte
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
            // Navegar a la página de versión
          },
        ),
        ListTile(
          title: Text('Términos y condiciones'),
          onTap: () {
            // Navegar a la página de términos y condiciones
          },
        ),
      ],
    );
  }
}
