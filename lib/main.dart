import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Pages/CartPage.dart';
import 'Pages/HomePage.dart';
import 'Pages/ItemPage.dart';
import 'Pages/FavoritesPage.dart';
import 'Pages/LoginPage.dart';
import 'Pages/RegisterPage.dart';
import 'Pages/SettingsPage.dart';
import 'Pages/AccountPage.dart';
import 'Pages/OrdersPage.dart';
import 'providers/CategoryProvider.dart';
import 'providers/CartProvider.dart';
import 'providers/FavoriteProvider.dart';
import 'providers/NotificationProvider.dart';
import 'providers/SearchProvider.dart';
import 'providers/UserProvider.dart';
import 'helpers/DatabaseHelper.dart';
import 'providers/ProductProvider.dart';
import 'providers/OrdersProvider.dart'; // Importar OrdersProvider
import 'models/Product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar la base de datos SQLite
  final dbHelper = DatabaseHelper();
  await dbHelper
      .database; // Asegurarse de que la base de datos esté inicializada

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(
            create: (context) => UserProvider()), // Añadir UserProvider
        ChangeNotifierProxyProvider<UserProvider, FavoriteProvider>(
          create: (context) => FavoriteProvider(),
          update: (context, userProvider, favoriteProvider) =>
              favoriteProvider!..setUser(userProvider.user),
        ),
        ChangeNotifierProxyProvider<UserProvider, NotificationProvider>(
          create: (context) => NotificationProvider(),
          update: (context, userProvider, notificationProvider) =>
              notificationProvider!..setUser(userProvider.user),
        ),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProxyProvider<UserProvider, OrdersProvider>(
          create: (context) => OrdersProvider(),
          update: (context, userProvider, ordersProvider) =>
              ordersProvider!..setUserProvider(userProvider),
        ),
      ],
      child: MaterialApp(
        title: "Fruit app",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFF5F5F3),
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
          '/register': (context) => RegisterPage(),
          '/home': (context) => HomePage(),
          '/cartPage': (context) => CartPage(),
          '/favoritesPage': (context) => FavoritesPage(),
          '/settings': (context) => SettingsPage(),
          '/account': (context) => AccountPage(),
          '/orders': (context) => OrdersPage(),
        },
      ),
    );
  }
}
