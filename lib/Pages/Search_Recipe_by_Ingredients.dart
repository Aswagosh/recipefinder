import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:tastybud/Pages/Details.dart';
import 'package:tastybud/Pages/Favourite_Recipe.dart';
import 'package:tastybud/Service/Recipe_Api_Service.dart';

class SearchByIngredients extends StatefulWidget {
  const SearchByIngredients({Key? key}) : super(key: key);

  @override
  State<SearchByIngredients> createState() => _SearchByIngredientsState();
}

class _SearchByIngredientsState extends State<SearchByIngredients> {
  final TextEditingController _controller = TextEditingController();
  final _apiService = ApiService();
  List _recipes = [];
  bool _isLoading = false;
  List<int> Favorites = [];
  bool _searchPerformed = false;
  String _selectedDiet = 'Any';

  void _searchRecipes() async {
    setState(() {
      _isLoading = true;
      _searchPerformed = true; // Set searchPerformed to true when search is initiated
    });

    try {
      final recipes = await _apiService.SearchRecipe(_controller.text);
      setState(() {
        _recipes = recipes;
      });
    } catch (e) {
      // Handle error
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _applyFilters() {
    // Implement filtering logic based on dietary preferences
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
                MaterialPageRoute(
                  builder: (context) => FavouriteRecipe(favoriteIds: Favorites),
                ),
              );
            },
            icon: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () async {
              var connectivityResult = await (Connectivity().checkConnectivity());
              if (connectivityResult == ConnectivityResult.none) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("No Internet"),
                    content: Text(
                      "Please check your internet connection and try again.",
                      style: TextStyle(color: Colors.black54),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("OK"),
                      ),
                    ],
                  ),
                );
              } else {
                _searchRecipes();
              }
            },
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: Colors.deepOrange,
        title: Text(
          'TastyBud',
          style: TextStyle(
            fontSize: 32,
            fontFamily: 'Anton',
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              "Find The Best Recipe For Cooking",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Gorditas',
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedDiet,
                    icon: Icon(Icons.filter_list),
                    iconSize: 30,
                    elevation: 16,
                    style: TextStyle(color: Colors.white),
                    dropdownColor: Colors.deepOrange,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedDiet = newValue!;
                        _applyFilters();
                      });
                    },
                    items: ['Any', 'Vegetarian', 'Vegan', 'Gluten-Free']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(color: Colors.white, fontSize: 18)),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelText: 'Enter ingredients (comma separated)',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var connectivityResult = await (Connectivity().checkConnectivity());
                if (connectivityResult == ConnectivityResult.none) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("No Internet"),
                      content: Text(
                        "Please check your internet connection and try again.",
                        style: TextStyle(color: Colors.black54),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                } else {
                  _searchRecipes();
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Search Recipe',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : _searchPerformed && _recipes.isEmpty
                ? Center(
              child: Text(
                'No recipes found',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
                : Expanded(
              child: ListView.builder(
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewDatas(),
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.network(
                                _recipes[index]['image'],
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _recipes[index]['title'],
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Ingredients:',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Display used ingredients
                                  for (var ingredient in _recipes[index]['usedIngredients'])
                                    Text(
                                      '- ${ingredient['name']}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black87,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            if (Favorites.contains(_recipes[index]['id'])) {
                                              Favorites.remove(_recipes[index]['id']);
                                            } else {
                                              Favorites.add(_recipes[index]['id']);
                                            }
                                          });
                                          print(Favorites);
                                        },
                                        icon: Icon(Icons.favorite),
                                        color: Favorites.contains(_recipes[index]['id'])
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Add to favorites',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      IconButton(
                                        onPressed: () {
                                          // Add functionality for another button here
                                        },
                                        icon: Icon(Icons.more_vert),
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
