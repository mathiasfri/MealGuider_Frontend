class Recipe {
  final int? id; // Nullable to handle missing values
  final String name;
  final String description;
  final String instructions;
  final String category;
  final String difficulty;
  final int time;
  final List<String> ingredients;
  final Nutrition nutrition;

  Recipe({
    this.id,
    required this.name,
    required this.description,
    required this.instructions,
    required this.category,
    required this.difficulty,
    required this.time,
    required this.ingredients,
    required this.nutrition,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      instructions: json['instructions'],
      category: json['category'],
      difficulty: json['difficulty'],
      time: json['time'],
      ingredients: List<String>.from(json['ingredients']),
      nutrition: Nutrition.fromJson(json['nutrition']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id, // Include id only if it's not null
      'name': name,
      'description': description,
      'instructions': instructions,
      'category': category,
      'difficulty': difficulty,
      'time': time,
      'ingredients': ingredients,
      'nutrition': nutrition.toJson(),
    };
  }
}

class Nutrition {
  final int? id;
  final int servings;
  final int calories;
  final int protein;
  final int fat;
  final int carbs;

  Nutrition({
    this.id,
    required this.servings,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
  });

  factory Nutrition.fromJson(Map<String, dynamic> json) {
    return Nutrition(
      id: json['id'],
      servings: json['servings'],
      calories: json['calories'],
      protein: json['protein'],
      fat: json['fat'],
      carbs: json['carbs'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'servings': servings,
      'calories': calories,
      'protein': protein,
      'fat': fat,
      'carbs': carbs,
    };
  }
}
