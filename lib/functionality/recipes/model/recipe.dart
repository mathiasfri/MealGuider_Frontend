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
}

class Nutrition {
  final int servings;
  final int calories;
  final int protein;
  final int fat;
  final int carbs;

  Nutrition({
    required this.servings,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
  });
}
