// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mealguider/functionality/recipes/model/recipe.dart';
import 'package:mealguider/functionality/user/model/user_settings.dart';
import 'package:mealguider/utils/constants.dart';

class RecipeService {
  Future<Recipe> generateRecipe(UserSettings userSettings) async {
    final response = await http.post(
      Uri.parse('$API_URL/recipe/generate'),
      headers: {"Content-Type": "application/json, charset=utf-8"},
      body: json.encode(userSettings.toJson()),
    );

    print("Response: ${response.body}");

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Recipe.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to generate recipe: ${response.statusCode}');
    }
  }

  Future<bool> saveRecipe(Recipe recipe, var userId) async {
    final response = await http.post(
      Uri.parse('$API_URL/recipe/save/$userId'),
      headers: {"Content-Type": "application/json, charset=utf-8"},
      body: json.encode(recipe.toJson()),
    );

    print("Response: ${response.body}");

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    } else {
      throw Exception('Failed to save recipe: ${response.statusCode}');
    }
  }

  Future<List<Recipe>> getRecipes(var userId) async {
    final response = await http.get(Uri.parse('$API_URL/recipe/list/$userId'));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> recipesJson = json.decode(response.body);
      return recipesJson.map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get recipes: ${response.statusCode}');
    }
  }
}
