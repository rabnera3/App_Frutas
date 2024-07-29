import 'package:hive/hive.dart';
import 'package:food_app/models/Category.dart';

void main() async {
  // Inicializa Hive
  Hive.init('hive_boxes');

  // Registrar adaptadores
  Hive.registerAdapter(CategoryAdapter());

  // Abrir la caja de categorías
  var categoryBox = await Hive.openBox<Category>('categoryBox');

  // Añadir categorías
  final List<Category> categories = [
    Category(id: 'c1', name: 'Frutas cítricas', imageUrl: 'images/naranja.png'),
    Category(
        id: 'c2', name: 'Frutas tropicales', imageUrl: 'images/banana.png'),
    Category(
        id: 'c3',
        name: 'Frutas de pepita y hueso',
        imageUrl: 'images/manzana.png'),
    Category(id: 'c4', name: 'Bayas', imageUrl: 'images/fresa.png'),
    Category(
        id: 'c5', name: 'Frutas exóticas', imageUrl: 'images/maracuya.png'),
    Category(id: 'c6', name: 'Frutas-verduras', imageUrl: 'images/tomate.png'),
  ];

  for (var category in categories) {
    categoryBox.put(category.id, category);
  }

  print('Categorías añadidas con éxito');
  await Hive.close();
}
