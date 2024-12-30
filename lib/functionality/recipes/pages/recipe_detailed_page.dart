import 'package:flutter/material.dart';
import 'package:mealguider/functionality/recipes/model/recipe.dart';
import 'package:mealguider/utils/code_constants.dart';

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailPage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Category: ${capitalize(recipe.category)}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "Difficulty: ${capitalize(recipe.difficulty)}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                "Time: ${recipe.time} minutes",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                "Description: ${recipe.description}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              const Text(
                "Ingredients:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(recipe.ingredients.join("\n")),
              const SizedBox(height: 16),
              const Text(
                "Instructions:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(recipe.instructions),
              const SizedBox(height: 16),
              const Text("Nutrition Information",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("Servings: ${recipe.nutrition.servings}"),
              Text("Calories: ${recipe.nutrition.calories} kcal"),
              Text("Protein: ${recipe.nutrition.protein} g"),
              Text("Fat: ${recipe.nutrition.fat} g"),
              Text("Carbs: ${recipe.nutrition.carbs} g"),
            ],
          ),
        ),
      ),
    );
  }
}
