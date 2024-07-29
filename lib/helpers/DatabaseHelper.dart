import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'food_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS cart_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        product_id TEXT NOT NULL,
        quantity INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS categories (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        image_url TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS favorites (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        product_id TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS notifications (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        message TEXT NOT NULL,
        date_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS products (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        image_url TEXT NOT NULL,
        short_description TEXT NOT NULL,
        long_description TEXT NOT NULL,
        category_id TEXT NOT NULL,
        FOREIGN KEY (category_id) REFERENCES categories (id)
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        date TEXT NOT NULL,
        total REAL NOT NULL,
        status TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        full_name TEXT NOT NULL,
        address TEXT NOT NULL,
        phone_number TEXT NOT NULL,
        birth_date TEXT NOT NULL,
        gender TEXT NOT NULL,
        email TEXT NOT NULL,
        password TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Insertar datos iniciales solo si las tablas están vacías
    await _insertInitialData(db);
  }

  Future<void> _insertInitialData(Database db) async {
    // Verificar si la tabla categories está vacía
    var result = await db.rawQuery('SELECT COUNT(*) FROM categories');
    int count = Sqflite.firstIntValue(result)!;
    if (count == 0) {
      await db.execute('''
        INSERT INTO categories (id, name, image_url) VALUES
        ('c1', 'Frutas cítricas', 'images/naranja.png'),
        ('c2', 'Frutas tropicales', 'images/banana.png'),
        ('c3', 'Frutas de pepita y hueso', 'images/manzana.png'),
        ('c4', 'Bayas', 'images/fresa.png'),
        ('c5', 'Frutas exóticas', 'images/maracuya.png'),
        ('c6', 'Frutas-verduras', 'images/tomate.png')
      ''');
    }

    // Verificar si la tabla products está vacía
    result = await db.rawQuery('SELECT COUNT(*) FROM products');
    count = Sqflite.firstIntValue(result)!;
    if (count == 0) {
      await db.execute('''
        INSERT INTO products (id, name, price, image_url, short_description, long_description, category_id) VALUES
        ('p1', 'Naranja', 5.0, 'images/naranja.png', 'Deliciosa y jugosa naranja.', 'Prueba nuestra deliciosa Naranja a bajo precio! Es famosa y te encantará. ¡Disfruta y ordena muchas veces', 'c1'),
        ('p2', 'Limón', 4.0, 'images/limon.png', 'Ácido y refrescante limón.', 'Prueba nuestro ácido y refrescante Limón a bajo precio! Es famoso y te encantará. ¡Disfruta y ordena muchas veces', 'c1'),
        ('p3', 'Lima', 4.0, 'images/lima.png', 'Ácida y refrescante lima.', 'Prueba nuestra ácida y refrescante Lima a bajo precio! Es famosa y te encantará. ¡Disfruta y ordena muchas veces', 'c1'),
        ('p4', 'Toronja', 6.0, 'images/toronja.png', 'Jugoso pomelo.', 'Prueba nuestro jugoso Pomelo a bajo precio! Es famoso y te encantará. ¡Disfruta y ordena muchas veces', 'c1'),
        ('p5', 'Mandarina', 5.0, 'images/mandarina.png', 'Dulce y jugosa mandarina.', 'Prueba nuestra dulce y jugosa Mandarina a bajo precio! Es famosa y te encantará. ¡Disfruta y ordena muchas veces', 'c1'),
        ('p6', 'Banana', 3.0, 'images/banana.png', 'Dulce y rica en potasio.', 'Prueba nuestra dulce y rica en potasio Banana a bajo precio! Es famosa y te encantará. ¡Disfruta y ordena muchas veces', 'c2'),
        ('p7', 'Piña', 6.0, 'images/pina.png', 'Refrescante piña tropical.', 'Prueba nuestra refrescante Piña tropical a bajo precio! Es famosa y te encantará. ¡Disfruta y ordena muchas veces', 'c2'),
        ('p8', 'Mango', 7.0, 'images/mango.png', 'Dulce y jugoso mango.', 'Prueba nuestro dulce y jugoso Mango a bajo precio! Es famoso y te encantará. ¡Disfruta y ordena muchas veces', 'c2'),
        ('p9', 'Papaya', 5.0, 'images/papaya.png', 'Refrescante papaya.', 'Prueba nuestra refrescante Papaya a bajo precio! Es famosa y te encantará. ¡Disfruta y ordena muchas veces', 'c2'),
        ('p10', 'Coco', 8.0, 'images/coco.png', 'Delicioso y nutritivo coco.', 'Prueba nuestro delicioso y nutritivo Coco a bajo precio! Es famoso y te encantará. ¡Disfruta y ordena muchas veces', 'c2'),
        ('p11', 'Sandía', 3.0, 'images/sandia.png', 'Refrescante sandía.', 'Prueba nuestra refrescante Sandía a bajo precio! Es famosa y te encantará. ¡Disfruta y ordena muchas veces', 'c2'),
        ('p12', 'Manzana', 4.0, 'images/manzana.png', 'Crujiente y saludable.', 'Prueba nuestra crujiente y saludable Manzana a bajo precio! Es famosa y te encantará. ¡Disfruta y ordena muchas veces', 'c3'),
        ('p13', 'Pera', 5.0, 'images/pera.png', 'Dulce y jugosa pera.', 'Prueba nuestra dulce y jugosa Pera a bajo precio! Es famosa y te encantará. ¡Disfruta y ordena muchas veces', 'c3'),
        ('p14', 'Durazno', 6.0, 'images/durazno.png', 'Dulce y jugoso durazno.', 'Prueba nuestro dulce y jugoso Durazno a bajo precio! Es famoso y te encantará. ¡Disfruta y ordena muchas veces', 'c3'),
        ('p15', 'Ciruela', 6.0, 'images/ciruela.png', 'Deliciosa ciruela.', 'Prueba nuestra deliciosa Ciruela a bajo precio! Es famosa y te encantará. ¡Disfruta y ordena muchas veces', 'c3'),
        ('p16', 'Cereza', 7.0, 'images/cereza.png', 'Dulce y jugosa cereza.', 'Prueba nuestra dulce y jugosa Cereza a bajo precio! Es famosa y te encantará. ¡Disfruta y ordena muchas veces', 'c3'),
        ('p17', 'Fresa', 6.0, 'images/fresa.png', 'Fresas suaves y dulces.', 'Prueba nuestras fresas suaves y dulces a bajo precio! Son famosas y te encantarán. ¡Disfruta y ordena muchas veces', 'c4'),
        ('p18', 'Arándano', 8.0, 'images/arandano.png', 'Arándanos frescos.', 'Prueba nuestros arándanos frescos a bajo precio! Son famosos y te encantarán. ¡Disfruta y ordena muchas veces', 'c4'),
        ('p19', 'Frambuesa', 7.0, 'images/frambuesa.png', 'Deliciosas frambuesas.', 'Prueba nuestras deliciosas frambuesas a bajo precio! Son famosas y te encantarán. ¡Disfruta y ordena muchas veces', 'c4'),
        ('p20', 'Mora', 6.0, 'images/mora.png', 'Jugosas moras.', 'Prueba nuestras jugosas moras a bajo precio! Son famosas y te encantarán. ¡Disfruta y ordena muchas veces', 'c4'),
        ('p21', 'Maracuyá', 10.0, 'images/maracuya.png', 'Exótico y delicioso maracuyá.', 'Prueba nuestro exótico y delicioso Maracuyá a bajo precio! Es famoso y te encantará. ¡Disfruta y ordena muchas veces', 'c5'),
        ('p22', 'Liches', 12.0, 'images/liche.png', 'Dulces y exóticos liches.', 'Prueba nuestros dulces y exóticos Liches a bajo precio! Son famosos y te encantarán. ¡Disfruta y ordena muchas veces', 'c5'),
        ('p23', 'Fruta del Dragon', 13.0, 'images/dragon.png', 'Delicioso Fruta del Dragon.', 'Prueba nuestra deliciosa Fruta del Dragon a bajo precio! Es famosa y te encantará. ¡Disfruta y ordena muchas veces', 'c5'),
        ('p24', 'Guayaba', 6.0, 'images/guayaba.png', 'Nutritiva guayaba.', 'Prueba nuestra nutritiva Guayaba a bajo precio! Es famosa y te encantará. ¡Disfruta y ordena muchas veces', 'c5'),
        ('p25', 'Kiwi', 8.0, 'images/kiwi.png', 'Exótico kiwi.', 'Prueba nuestro exótico Kiwi a bajo precio! Es famoso y te encantará. ¡Disfruta y ordena muchas veces', 'c5'),
        ('p26', 'Tomate', 3.0, 'images/tomate.png', 'Ideal para ensaladas.', 'Prueba nuestro tomate ideal para ensaladas a bajo precio! Es famoso y te encantará. ¡Disfruta y ordena muchas veces', 'c6'),
        ('p27', 'Pepino', 2.0, 'images/pepino.png', 'Fresco y crujiente.', 'Prueba nuestro fresco y crujiente Pepino a bajo precio! Es famoso y te encantará. ¡Disfruta y ordena muchas veces', 'c6'),
        ('p28', 'Ayote', 4.0, 'images/ayote.png', 'Perfecta para sopas y purés.', 'Prueba nuestro ayote perfecto para sopas y purés a bajo precio! Es famoso y te encantará. ¡Disfruta y ordena muchas veces', 'c6'),
        ('p29', 'Berenjena', 4.0, 'images/berenjena.png', 'Ideal para asados.', 'Prueba nuestra berenjena ideal para asados a bajo precio! Es famosa y te encantará. ¡Disfruta y ordena muchas veces', 'c6'),
        ('p30', 'Aguacate', 5.0, 'images/aguacate.png', 'Perfecto para guacamole.', 'Prueba nuestro aguacate perfecto para guacamole a bajo precio! Es famoso y te encantará. ¡Disfruta y ordena muchas veces', 'c6')
      ''');
    }
  }

  Future<List<Map<String, dynamic>>> query(String table) async {
    Database db = await database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> rawQuery(String sql,
      [List<dynamic>? arguments]) async {
    Database db = await database;
    return await db.rawQuery(sql, arguments);
  }

  Future<void> execute(String sql, [List<dynamic>? arguments]) async {
    Database db = await database;
    await db.execute(sql, arguments);
  }

  Future<int> insert(String table, Map<String, dynamic> values) async {
    Database db = await database;
    return await db.insert(table, values);
  }

  Future<int> update(String table, Map<String, dynamic> values,
      String whereClause, List<dynamic> whereArgs) async {
    Database db = await database;
    return await db.update(table, values,
        where: whereClause, whereArgs: whereArgs);
  }

  Future<int> delete(
      String table, String whereClause, List<dynamic> whereArgs) async {
    Database db = await database;
    return await db.delete(table, where: whereClause, whereArgs: whereArgs);
  }
}
