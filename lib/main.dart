import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Pages/CartPage.dart';
import 'Pages/HomePage.dart';
import 'Pages/ItemPage.dart';
import 'Pages/FavoritesPage.dart';
import 'Pages/LoginPage.dart';
import 'Pages/RegisterPage.dart' as register;
import 'Pages/SettingsPage.dart' as settings;
import 'providers/CartProvider.dart';
import 'providers/FavoriteProvider.dart';
import 'providers/NotificationProvider.dart';
import 'providers/SearchProvider.dart';
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
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
      ],
      child: MaterialApp(
        title: "Fruit app",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFF5F5F3),
          primaryColor: Colors.red,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.redAccent),
        ),
        initialRoute: '/login',
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
          '/login': (context) => LoginPage(),
          '/register': (context) => register.RegisterPage(),
          '/home': (context) => HomePage(),
          '/cartPage': (context) => CartPage(),
          '/favoritesPage': (context) => FavoritesPage(),
          '/settings': (context) => settings.SettingsPage(),
        },
      ),
    );
  }
}
