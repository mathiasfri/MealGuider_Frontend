import 'package:mealguider/functionality/recipes/model/recipe.dart';
import 'package:mealguider/functionality/user/model/user_settings.dart';

class User {
  final int id;
  final String email;
  final List<String> allergies;
  final UserSettings userSettings;
  final List<Recipe> recipes;

  User({
    required this.id,
    required this.email,
    required this.allergies,
    required this.userSettings,
    required this.recipes,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      allergies: json['allergies'].cast<String>(),
      userSettings: UserSettings.fromJson(json['userSettings']),
      recipes: json['recipes']
          .map<Recipe>((recipe) => Recipe.fromJson(recipe))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'allergies': allergies,
      'userSettings': userSettings.toJson(),
      'recipes': recipes.map((recipe) => recipe.toJson()).toList(),
    };
  }
}
