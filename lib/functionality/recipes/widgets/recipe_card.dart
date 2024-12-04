import 'package:flutter/material.dart';
import 'package:mealguider/functionality/recipes/model/recipe.dart';
import 'package:mealguider/functionality/recipes/pages/recipe_detailed_page.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  void _showNutritionPopup(BuildContext context, Nutrition nutrition) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Nutrition Information"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Servings: ${nutrition.servings}"),
              Text("Calories: ${nutrition.calories} kcal"),
              Text("Protein: ${nutrition.protein} g"),
              Text("Fat: ${nutrition.fat} g"),
              Text("Carbs: ${nutrition.carbs} g"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(recipe.name),
        subtitle: Text(
          "Category: ${recipe.category}\nDifficulty: ${recipe.difficulty}\nTime: ${recipe.time} min",
        ),
        trailing: IconButton(
          icon: const Icon(Icons.info),
          onPressed: () => _showNutritionPopup(context, recipe.nutrition),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailPage(recipe: recipe),
            ),
          );
        },
      ),
    );
  }
}
