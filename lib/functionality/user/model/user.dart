import 'package:mealguider/functionality/recipes/model/recipe.dart';
import 'package:mealguider/functionality/user/model/user_settings.dart';

class User {
  final int id;
  final String email;
  final UserSettings userSettings;
  final List<Recipe> recipes;

  User({
    required this.id,
    required this.email,
    required this.userSettings,
    required this.recipes,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      userSettings: UserSettings.fromJson(json['userSettings']),
      recipes: json['recipes']
          .map<Recipe>((recipe) => Recipe.fromJson(recipe))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'userSettings': userSettings.toJson(),
      'recipes': recipes.map((recipe) => recipe.toJson()).toList(),
    };
  }
}
