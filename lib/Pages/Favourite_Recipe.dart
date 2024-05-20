import 'package:flutter/material.dart';
import 'package:tastybud/Models/Recipe_Model.dart'; // Import Recipe model
import 'package:tastybud/Pages/Home_Screen.dart'; // Import the Home screen or wherever you navigate back
import 'package:tastybud/Service/Recipe_Api_Service.dart'; // Import the service to fetch recipes by ID

class FavouriteRecipe extends StatefulWidget {
  final List<int> favoriteIds;

  const FavouriteRecipe({Key? key, required this.favoriteIds}) : super(key: key);

  @override
  State<FavouriteRecipe> createState() => _FavouriteRecipeState();
}

class _FavouriteRecipeState extends State<FavouriteRecipe> {
  final _apiService = ApiService(); // Instantiate the API service

  List<Recipes> favoriteRecipes = []; // List to store favorite recipes

  @override
  void initState() {
    super.initState();
    // Fetch favorite recipes from API
    _fetchFavoriteRecipes();
  }

  void _fetchFavoriteRecipes() async {
    for (int id in widget.favoriteIds) {
      Recipes recipe = await _apiService.SearchRecipe(id as String);
      setState(() {
        favoriteRecipes.add(recipe);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: Colors.deepOrange,
        title: Center(
          child: Text(
            'Favorite Recipes',
            style: TextStyle(
              fontSize: 40,
              fontFamily: 'Anton',
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: favoriteRecipes.length,
        itemBuilder: (context, index) {
          Recipes recipe = favoriteRecipes[index];
          return Card(
            child: ListTile(
              title: Text(recipe.title),
              subtitle: Text("ID: ${recipe.id}"),
              trailing: ElevatedButton(
                onPressed: () {
                  // Navigate to full recipe view
                  // You can implement this based on your app's navigation
                },
                child: Text(
                  'View Recipe',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
