import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 243, 90, 66),
            title: const Text("LOGIN")),
        body: cuerpo());
  }
}


Widget cuerpo() {
  return Container(
    child: Center(
      child: Column(
        children: [usuario(), btn_usuario(), btn_informacion()],
      ),
    ),
  );
}

Widget usuario() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
    child: TextField(
      decoration: InputDecoration(
        hintText: "Usuario:",
        fillColor: Color.fromARGB(189, 255, 255, 255),
        filled: true,
      ),
    ),
  );
}


Widget btn_usuario() {
  return ElevatedButton(onPressed: () {}, 
  child: const Text("INGRESAR"));
}

Widget btn_informacion() {
  return ElevatedButton(onPressed: () {}, 
  child: const Text("INFORMACION"));
}