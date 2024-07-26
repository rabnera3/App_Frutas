import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Pages/CartPage.dart';
import 'Pages/HomePage.dart'; // Importa HomePage
import 'Pages/ItemPage.dart';
import 'providers/CartProvider.dart';
import 'providers/NotificationProvider.dart'; // Importa NotificationProvider
import 'providers/SearchProvider.dart'; // Importa SearchProvider
import 'models/Product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(
            create: (context) =>
                NotificationProvider()), // Añade NotificationProvider
        ChangeNotifierProvider(
            create: (context) => SearchProvider()), // Añade SearchProvider
      ],
      child: MaterialApp(
        title: "Fruit app",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFF5F5F3),
        ),
        onGenerateRoute: (settings) {
          if (settings.name == 'itemPage') {
            final product = settings.arguments as Product;
            return MaterialPageRoute(
              builder: (context) => ItemPage(product: product),
            );
          }
          return null;
        },
        routes: {
          "/": (context) => HomePage(),
          "cartPage": (context) => CartPage(),
        },
      ),
    );
  }
}
