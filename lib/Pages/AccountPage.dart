import 'package:flutter/material.dart';
import '../Widgets/DrawerWidget.dart';
import '../Widgets/AppBarWidget.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = "Nombre del Usuario";
  String _email = "usuario@correo.com";
  String _phoneNumber = "+504 1234-5678";
  String _address = "Dirección del Usuario";
  String _password = "";

  void _editInformation(String field, String value) {
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
                setState(() {
                  switch (field) {
                    case "Nombre Completo":
                      _fullName = _textController.text;
                      break;
                    case "Correo Electrónico":
                      _email = _textController.text;
                      break;
                    case "Número de Teléfono":
                      _phoneNumber = _textController.text;
                      break;
                    case "Dirección":
                      _address = _textController.text;
                      break;
                  }
                });
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
  }

  void _changePassword() {
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
                  decoration:
                      InputDecoration(hintText: "Ingrese nueva contraseña"),
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
                  setState(() {
                    _password = _textController.text;
                  });
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
  }

  void _deleteAccount() {
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
                // Implementar la lógica de eliminación de cuenta aquí
                Navigator.of(context).pop();
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
  }

  void _logout() {
    // Implementar el cierre de sesión aquí
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
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
                      _fullName,
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
                      subtitle: Text(_fullName),
                      trailing: Icon(Icons.edit),
                      onTap: () =>
                          _editInformation("Nombre Completo", _fullName),
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text("Correo Electrónico"),
                      subtitle: Text(_email),
                      trailing: Icon(Icons.edit),
                      onTap: () =>
                          _editInformation("Correo Electrónico", _email),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text("Número de Teléfono"),
                      subtitle: Text(_phoneNumber),
                      trailing: Icon(Icons.edit),
                      onTap: () =>
                          _editInformation("Número de Teléfono", _phoneNumber),
                    ),
                    ListTile(
                      leading: Icon(Icons.location_on),
                      title: Text("Dirección"),
                      subtitle: Text(_address),
                      trailing: Icon(Icons.edit),
                      onTap: () => _editInformation("Dirección", _address),
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
