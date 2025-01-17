// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:mealguider/functionality/recipes/model/recipe.dart';
import 'package:mealguider/functionality/user/model/user_settings.dart';
import 'package:mealguider/utils/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class RecipeService {
  Future<Recipe> generateRecipe(UserSettings userSettings) async {
    final response = await http.post(
      Uri.parse('$API_URL/recipe/generate'),
      headers: {"Content-Type": "application/json; charset=utf-8"},
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
      headers: {"Content-Type": "application/json; charset=utf-8"},
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

  Future<void> deleteRecipe(int recipeId) async {
    try {
      final response = await http.delete(
        Uri.parse('$API_URL/recipe/delete/$recipeId'),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("Recipe deleted successfully");
      } else {
        throw Exception('Failed to delete recipe: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting recipe: $e');
    }
  }

  Future<void> downloadRecipe(int recipeId, String recipeName) async {
    await Permission.storage.request();
    try {
      Dio dio = Dio();
      final response = await dio.get('$API_URL/recipe/download/$recipeId',
          options: Options(responseType: ResponseType.bytes));

      // Get the downloads directory
      final directory = await getExternalStorageDirectory();

      // Save to downloads folder
      final filePath = '${directory!.path}/Download/$recipeName.pdf';
      final file = File(filePath);
      await file.writeAsBytes(response.data);

      print("PDF saved at $filePath");
    } catch (e) {
      print(e);
      throw Exception('Error downloading recipe: $e');
    }
  }
}
