import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tastybud/Models/Recipe_Model.dart';

class ApiService {

  Future<dynamic> SearchRecipe(String ingredients) async {
    var client = http.Client();
    var apiUrl = Uri.parse(
        "https://api.spoonacular.com/recipes/findByIngredients?apiKey=56f64e53acfb49f3b64df2d5e350aedd&ingredients=" +
            ingredients);
    final response = await client.get(apiUrl, headers: <String, String>{
      'Content-Type': 'application/json;charset=utf-8'
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return throw Exception("Failed to load data");
    }
  }
}
