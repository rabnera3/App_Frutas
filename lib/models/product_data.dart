import 'Product.dart';

final List<Product> products = [
  // Frutas cítricas
  Product(
    id: 'p1',
    name: 'Naranja',
    price: 5.0,
    imageUrl: 'images/naranja.png',
    description: 'Deliciosa y jugosa naranja.',
    categoryId: 'c1',
    category: 'Frutas cítricas',
  ),
  Product(
    id: 'p2',
    name: 'Limón',
    price: 4.0,
    imageUrl: 'images/limon.png',
    description: 'Ácido y refrescante limón.',
    categoryId: 'c1',
    category: 'Frutas cítricas',
  ),
  Product(
    id: 'p3',
    name: 'Lima',
    price: 4.0,
    imageUrl: 'images/lima.png',
    description: 'Ácida y refrescante lima.',
    categoryId: 'c1',
    category: 'Frutas cítricas',
  ),
  Product(
    id: 'p4',
    name: 'Toronja',
    price: 6.0,
    imageUrl: 'images/toronja.png',
    description: 'Jugoso pomelo.',
    categoryId: 'c1',
    category: 'Frutas cítricas',
  ),
  Product(
    id: 'p5',
    name: 'Mandarina',
    price: 5.0,
    imageUrl: 'images/mandarina.png',
    description: 'Dulce y jugosa mandarina.',
    categoryId: 'c1',
    category: 'Frutas cítricas',
  ),
  // Frutas tropicales
  Product(
    id: 'p6',
    name: 'Banana',
    price: 3.0,
    imageUrl: 'images/banana.png',
    description: 'Dulce y rica en potasio.',
    categoryId: 'c2',
    category: 'Frutas tropicales',
  ),
  Product(
    id: 'p7',
    name: 'Piña',
    price: 6.0,
    imageUrl: 'images/pina.png',
    description: 'Refrescante piña tropical.',
    categoryId: 'c2',
    category: 'Frutas tropicales',
  ),
  Product(
    id: 'p8',
    name: 'Mango',
    price: 7.0,
    imageUrl: 'images/mango.png',
    description: 'Dulce y jugoso mango.',
    categoryId: 'c2',
    category: 'Frutas tropicales',
  ),
  Product(
    id: 'p9',
    name: 'Papaya',
    price: 5.0,
    imageUrl: 'images/papaya.png',
    description: 'Refrescante papaya.',
    categoryId: 'c2',
    category: 'Frutas tropicales',
  ),
  Product(
    id: 'p10',
    name: 'Coco',
    price: 8.0,
    imageUrl: 'images/coco.png',
    description: 'Delicioso y nutritivo coco.',
    categoryId: 'c2',
    category: 'Frutas tropicales',
  ),
  Product(
    id: 'p11',
    name: 'Sandía',
    price: 3.0,
    imageUrl: 'images/sandia.png',
    description: 'Refrescante sandía.',
    categoryId: 'c2',
    category: 'Frutas tropicales',
  ),
  // Frutas de pepita y hueso
  Product(
    id: 'p12',
    name: 'Manzana',
    price: 4.0,
    imageUrl: 'images/manzana.png',
    description: 'Crujiente y saludable.',
    categoryId: 'c3',
    category: 'Frutas de pepita y hueso',
  ),
  Product(
    id: 'p13',
    name: 'Pera',
    price: 5.0,
    imageUrl: 'images/pera.png',
    description: 'Dulce y jugosa pera.',
    categoryId: 'c3',
    category: 'Frutas de pepita y hueso',
  ),
  Product(
    id: 'p14',
    name: 'Durazno',
    price: 6.0,
    imageUrl: 'images/durazno.png',
    description: 'Dulce y jugoso durazno.',
    categoryId: 'c3',
    category: 'Frutas de pepita y hueso',
  ),
  Product(
    id: 'p15',
    name: 'Ciruela',
    price: 6.0,
    imageUrl: 'images/ciruela.png',
    description: 'Deliciosa ciruela.',
    categoryId: 'c3',
    category: 'Frutas de pepita y hueso',
  ),
  Product(
    id: 'p16',
    name: 'Cereza',
    price: 7.0,
    imageUrl: 'images/cereza.png',
    description: 'Dulce y jugosa cereza.',
    categoryId: 'c3',
    category: 'Frutas de pepita y hueso',
  ),
  // Bayas
  Product(
    id: 'p17',
    name: 'Fresa',
    price: 6.0,
    imageUrl: 'images/fresa.png',
    description: 'Fresas suaves y dulces.',
    categoryId: 'c4',
    category: 'Bayas',
  ),
  Product(
    id: 'p18',
    name: 'Arándano',
    price: 8.0,
    imageUrl: 'images/arandano.png',
    description: 'Arándanos frescos.',
    categoryId: 'c4',
    category: 'Bayas',
  ),
  Product(
    id: 'p19',
    name: 'Frambuesa',
    price: 7.0,
    imageUrl: 'images/frambuesa.png',
    description: 'Deliciosas frambuesas.',
    categoryId: 'c4',
    category: 'Bayas',
  ),
  Product(
    id: 'p20',
    name: 'Mora',
    price: 6.0,
    imageUrl: 'images/mora.png',
    description: 'Jugosas moras.',
    categoryId: 'c4',
    category: 'Bayas',
  ),
  // Frutas exóticas
  Product(
    id: 'p21',
    name: 'Maracuyá',
    price: 10.0,
    imageUrl: 'images/maracuya.png',
    description: 'Exótico y delicioso maracuyá.',
    categoryId: 'c5',
    category: 'Frutas exóticas',
  ),
  Product(
    id: 'p22',
    name: 'Liches',
    price: 12.0,
    imageUrl: 'images/liche.png',
    description: 'Dulces y exóticos liches.',
    categoryId: 'c5',
    category: 'Frutas exóticas',
  ),
  Product(
    id: 'p23',
    name: 'Fruta del Dragon',
    price: 13.0,
    imageUrl: 'images/dragon.png',
    description: 'Delicioso Fruta del Dragon.',
    categoryId: 'c5',
    category: 'Frutas exóticas',
  ),
  Product(
    id: 'p24',
    name: 'Guayaba',
    price: 6.0,
    imageUrl: 'images/guayaba.png',
    description: 'Nutritiva guayaba.',
    categoryId: 'c5',
    category: 'Frutas exóticas',
  ),
  Product(
    id: 'p25',
    name: 'Kiwi',
    price: 8.0,
    imageUrl: 'images/kiwi.png',
    description: 'Exótico kiwi.',
    categoryId: 'c5',
    category: 'Frutas exóticas',
  ),
  // Frutas-verduras
  Product(
    id: 'p26',
    name: 'Tomate',
    price: 3.0,
    imageUrl: 'images/tomate.png',
    description: 'Ideal para ensaladas.',
    categoryId: 'c6',
    category: 'Frutas-verduras',
  ),
  Product(
    id: 'p27',
    name: 'Pepino',
    price: 2.0,
    imageUrl: 'images/pepino.png',
    description: 'Fresco y crujiente.',
    categoryId: 'c6',
    category: 'Frutas-verduras',
  ),
  Product(
    id: 'p28',
    name: 'Ayote',
    price: 4.0,
    imageUrl: 'images/ayote.png',
    description: 'Perfecta para sopas y purés.',
    categoryId: 'c6',
    category: 'Frutas-verduras',
  ),
  Product(
    id: 'p29',
    name: 'Berenjena',
    price: 4.0,
    imageUrl: 'images/berenjena.png',
    description: 'Ideal para asados.',
    categoryId: 'c6',
    category: 'Frutas-verduras',
  ),
  Product(
    id: 'p30',
    name: 'Aguacate',
    price: 5.0,
    imageUrl: 'images/aguacate.png',
    description: 'Perfecto para guacamole.',
    categoryId: 'c6',
    category: 'Frutas-verduras',
  ),
];