import 'package:mealguider/models/recipe.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RecipeService {
  final _supabase = Supabase.instance.client;

  Future<List<Recipe>> getRecipes() async {
    final userId = _supabase.auth.currentUser!.id;

    final response = await _supabase
        .from('recipe')
        .select('*, nutrition(*)')
        .eq('user_id', userId);

    return (response as List)
        .map((json) => Recipe.fromJson(json))
        .toList();
  }

  Future<Recipe> saveRecipe(Recipe recipe) async {
    final userId = _supabase.auth.currentUser!.id;

    // Insert the recipe
    final recipeJson = recipe.toInsertJson();
    recipeJson['user_id'] = userId;

    final recipeResponse = await _supabase
        .from('recipe')
        .insert(recipeJson)
        .select()
        .single();

    // Insert nutrition if present
    if (recipe.nutrition != null) {
      final nutritionJson = recipe.nutrition!.toJson();
      nutritionJson['recipe_id'] = recipeResponse['id'];

      await _supabase
          .from('nutrition')
          .insert(nutritionJson);
    }

    // Return the full recipe with nutrition
    final fullResponse = await _supabase
        .from('recipe')
        .select('*, nutrition(*)')
        .eq('id', recipeResponse['id'])
        .single();

    return Recipe.fromJson(fullResponse);
  }

  Future<void> deleteRecipe(int recipeId) async {
    await _supabase
        .from('recipe')
        .delete()
        .eq('id', recipeId);
  }
}
