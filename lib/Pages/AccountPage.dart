import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/UserProvider.dart';
import '../models/User.dart';
import '../Widgets/DrawerWidget.dart';
import '../Widgets/AppBarWidget.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  void _showPasswordDialog(Function(String) onPasswordEntered) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Ingrese su Contraseña"),
          content: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(hintText: "Contraseña"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onPasswordEntered(_passwordController.text);
                _passwordController.clear();
              },
              child: Text("Aceptar"),
            ),
            TextButton(
              onPressed: () {
                _passwordController.clear();
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
            ),
          ],
        );
      },
    );
  }

  void _editInformation(String field, String value) {
    _showPasswordDialog((password) async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      User? user = userProvider.user;

      if (user != null) {
        bool isPasswordCorrect = await userProvider.verifyPassword(password);
        if (isPasswordCorrect) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              final _textController = TextEditingController(text: value);
              return AlertDialog(
                title: Text("Editar $field"),
                content: TextField(
                  controller: _textController,
                  decoration: InputDecoration(hintText: "Ingrese $field"),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Map<String, dynamic> updates = {};
                      switch (field) {
                        case "Nombre Completo":
                          updates['full_name'] = _textController.text;
                          break;
                        case "Correo Electrónico":
                          updates['email'] = _textController.text;
                          break;
                        case "Número de Teléfono":
                          updates['phone_number'] = _textController.text;
                          break;
                        case "Dirección":
                          updates['address'] = _textController.text;
                          break;
                      }
                      userProvider.updateUser(updates);
                      Navigator.of(context).pop();
                    },
                    child: Text("Guardar"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancelar"),
                  ),
                ],
              );
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Contraseña incorrecta')),
          );
        }
      }
    });
  }

  void _changePassword() {
    _showPasswordDialog((password) async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      User? user = userProvider.user;

      if (user != null) {
        bool isPasswordCorrect = await userProvider.verifyPassword(password);
        if (isPasswordCorrect) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              final _textController = TextEditingController();
              return AlertDialog(
                title: Text("Cambiar Contraseña"),
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        obscureText: true,
                        controller: _textController,
                        decoration: InputDecoration(
                            hintText: "Ingrese nueva contraseña"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Por favor ingrese una contraseña";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        userProvider
                            .updateUser({'password': _textController.text});
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text("Guardar"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancelar"),
                  ),
                ],
              );
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Contraseña incorrecta')),
          );
        }
      }
    });
  }

  void _deleteAccount() {
    _showPasswordDialog((password) async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      User? user = userProvider.user;

      if (user != null) {
        bool isPasswordCorrect = await userProvider.verifyPassword(password);
        if (isPasswordCorrect) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Eliminar Cuenta"),
                content: Text(
                    "¿Estás seguro de que deseas eliminar tu cuenta? Esta acción no se puede deshacer."),
                actions: [
                  TextButton(
                    onPressed: () {
                      userProvider.deleteUser();
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text("Eliminar"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancelar"),
                  ),
                ],
              );
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Contraseña incorrecta')),
          );
        }
      }
    });
  }

  void _logout() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.logout();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    User? user = userProvider.user;

    if (user == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              AppBarWidget(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("images/avatar.jpg"),
                    ),
                    SizedBox(height: 20),
                    Text(
                      user.fullName,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Información Personal",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(thickness: 1),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text("Nombre Completo"),
                      subtitle: Text(user.fullName),
                      trailing: Icon(Icons.edit),
                      onTap: () =>
                          _editInformation("Nombre Completo", user.fullName),
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text("Correo Electrónico"),
                      subtitle: Text(user.email),
                      trailing: Icon(Icons.edit),
                      onTap: () =>
                          _editInformation("Correo Electrónico", user.email),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text("Número de Teléfono"),
                      subtitle: Text(user.phoneNumber),
                      trailing: Icon(Icons.edit),
                      onTap: () => _editInformation(
                          "Número de Teléfono", user.phoneNumber),
                    ),
                    ListTile(
                      leading: Icon(Icons.location_on),
                      title: Text("Dirección"),
                      subtitle: Text(user.address),
                      trailing: Icon(Icons.edit),
                      onTap: () => _editInformation("Dirección", user.address),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Configuración de Cuenta",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(thickness: 1),
                    ListTile(
                      leading: Icon(Icons.lock),
                      title: Text("Cambiar Contraseña"),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: _changePassword,
                    ),
                    ListTile(
                      leading: Icon(Icons.delete),
                      title: Text("Eliminar Cuenta"),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: _deleteAccount,
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: _logout,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          "Cerrar Sesión",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: DrawerWidget(),
    );
  }
}
