class Recipe {
  final int id;
  final String name;
  final String category;
  final String difficulty;
  final int time;
  final Nutrition nutrition;

  Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.difficulty,
    required this.time,
    required this.nutrition,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      difficulty: json['difficulty'],
      time: json['time'],
      nutrition: Nutrition.fromJson(json['nutrition']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'difficulty': difficulty,
      'time': time,
      'nutrition': nutrition.toJson(),
    };
  }
}

class Nutrition {
  final int id;
  final int servings;
  final int calories;
  final int protein;
  final int fat;
  final int carbs;

  Nutrition({
    required this.id,
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
      'servings': servings,
      'calories': calories,
      'protein': protein,
      'fat': fat,
      'carbs': carbs,
    };
  }
}
