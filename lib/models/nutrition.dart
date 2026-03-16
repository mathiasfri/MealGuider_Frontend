class Nutrition {
  final int? id;
  final int? recipeId;
  final int servings;
  final int calories;
  final int protein;
  final int fat;
  final int carbs;

  Nutrition({
    this.id,
    this.recipeId,
    this.servings = 1,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
  });

  factory Nutrition.fromJson(Map<String, dynamic> json) {
    return Nutrition(
      id: json['id'],
      recipeId: json['recipe_id'],
      servings: json['servings'] ?? 1,
      calories: json['calories'] ?? 0,
      protein: json['protein'] ?? 0,
      fat: json['fat'] ?? 0,
      carbs: json['carbs'] ?? 0,
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