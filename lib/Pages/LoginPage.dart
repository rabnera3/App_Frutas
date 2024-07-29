import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/UserProvider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 40),
                    Image.asset(
                      'images/logo.png', // Asegúrate de que la imagen del logo esté en la carpeta correcta
                      height: 100,
                    ),
                    SizedBox(height: 40),
                    Text(
                      "Iniciar Sesión",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 40),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "Usuario",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: "Contraseña",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        String username = _usernameController.text;
                        String password = _passwordController.text;

                        bool loginSuccess =
                            await userProvider.login(username, password);
                        if (loginSuccess) {
                          Navigator.pushReplacementNamed(context, '/home');
                        } else {
                          // Manejar el error de inicio de sesión
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Error'),
                              content: Text(
                                  'Nombre de usuario o contraseña incorrectos.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          "Iniciar Sesión",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text("¿No tienes cuenta? Regístrate"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
