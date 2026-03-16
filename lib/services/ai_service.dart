import 'package:mealguider/models/recipe.dart';
import 'package:mealguider/models/user_settings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AiService {
  final _supabase = Supabase.instance.client;

  Future<Recipe> generateRecipe(UserSettings userSettings) async {
    final response = await _supabase.functions.invoke(
      'generate-recipe',
      body: {
        'age': userSettings.age,
        'weight': userSettings.weight,
        'height': userSettings.height,
        'gender': userSettings.gender,
        'workoutRate': userSettings.workoutRate,
        'weightGoal': userSettings.weightGoal,
        'allergies': userSettings.allergies,
      },
    );

    if (response.status != 200) {
      throw Exception('Failed to generate recipe: ${response.data}');
    }

    return Recipe.fromJson(Map<String, dynamic>.from(response.data));
  }
}
