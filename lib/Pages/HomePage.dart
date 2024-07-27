import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widgets/AppBarWidget.dart';
import '../Widgets/CategoriesWidget.dart';
import '../Widgets/DrawerWidget.dart';
import '../Widgets/NewestItemsWidget.dart' as newest;
import '../Widgets/PopularItemsWidget.dart' as popular;
import '../providers/SearchProvider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategoryId = '';
  String selectedCategoryName = '';

  void _onCategorySelected(String categoryId, String categoryName) {
    setState(() {
      if (selectedCategoryId == categoryId) {
        selectedCategoryId = ''; // Desactivar categoría si ya está seleccionada
        selectedCategoryName = '';
      } else {
        selectedCategoryId = categoryId;
        selectedCategoryName = categoryName;
      }
      print(
          "Selected Category ID: $selectedCategoryId, Name: $selectedCategoryName"); // Agregado para depuración
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          // Custom App Bar Widget
          AppBarWidget(),

          // Search
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.search,
                      color: Colors.red,
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: TextFormField(
                          onChanged: (value) {
                            searchProvider.updateSearchQuery(value);
                            print(
                                "Search Query: ${searchProvider.searchQuery}"); // Agregado para depuración
                          },
                          decoration: InputDecoration(
                            hintText: "¿Qué te gustaría obtener?",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Icon(Icons.filter_list),
                  ],
                ),
              ),
            ),
          ),

          // Category
          Padding(
            padding: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              "Categorías",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),

          // Category Widget
          CategoriesWidget(
            onCategorySelected: _onCategorySelected,
            selectedCategoryId: selectedCategoryId,
          ),

          if (selectedCategoryId.isEmpty) ...[
            // Popular Items
            Padding(
              padding: EdgeInsets.only(top: 20, left: 10),
              child: Text(
                "Más Vendidos",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),

            // Popular Items Widget
            popular.PopularItemsWidget(
              searchQuery: searchProvider.searchQuery,
              categoryId: selectedCategoryId,
            ),

            // Newest Items
            Padding(
              padding: EdgeInsets.only(top: 20, left: 10),
              child: Text(
                "Lo Más Fresco",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),

            // Newest Item Widget
            newest.NewestItemsWidget(
              searchQuery: searchProvider.searchQuery,
              categoryId: selectedCategoryId,
            ),
          ] else ...[
            // Category Title
            Padding(
              padding: EdgeInsets.only(top: 20, left: 10),
              child: Text(
                selectedCategoryName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),

            // Category Items Widget
            newest.NewestItemsWidget(
              searchQuery: searchProvider.searchQuery,
              categoryId: selectedCategoryId,
            ),
          ],
        ],
      ),
      drawer: DrawerWidget(),
      floatingActionButton: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ]),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "cartPage");
          },
          child: Icon(
            CupertinoIcons.cart,
            size: 28,
            color: Colors.red,
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
