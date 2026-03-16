import 'nutrition.dart';

class Recipe {
  final int? id;
  final String? userId;
  final String name;
  final String? description;
  final String? instructions;
  final String? category;
  final String? difficulty;
  final int time;
  final List<String> ingredients;
  final Nutrition? nutrition;

  Recipe({
    this.id,
    this.userId,
    required this.name,
    this.description,
    this.instructions,
    this.category,
    this.difficulty,
    this.time = 0,
    this.ingredients = const [],
    this.nutrition,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'] ?? '',
      description: json['description'],
      instructions: json['instructions'],
      category: json['category'],
      difficulty: json['difficulty'],
      time: json['time'] ?? 0,
      ingredients: List<String>.from(json['ingredients'] ?? []),
      nutrition: json['nutrition'] != null
          ? Nutrition.fromJson(json['nutrition'] is List
              ? json['nutrition'][0]  // Supabase returns joined 1-to-1 as a list
              : json['nutrition'])
          : null,
    );
  }

  Map<String, dynamic> toInsertJson() {
    return {
      'name': name,
      'description': description,
      'instructions': instructions,
      'category': category?.toUpperCase(),
      'difficulty': difficulty?.toUpperCase(),
      'time': time,
      'ingredients': ingredients,
    };
  }
}