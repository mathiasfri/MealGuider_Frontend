import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mealguider/functionality/recipes/model/recipe.dart';
import 'package:mealguider/functionality/recipes/service/recipe_service.dart';
import 'package:mealguider/functionality/user/service/user_service.dart';

class RecipeGenerationPage extends StatefulWidget {
  const RecipeGenerationPage({super.key});

  @override
  _RecipeGenerationPageState createState() => _RecipeGenerationPageState();
}

class _RecipeGenerationPageState extends State<RecipeGenerationPage> {
  bool isLoading = false;
  Recipe? generatedRecipe;

  Future<void> _generateRecipe() async {
    setState(() {
      isLoading = true;
      generatedRecipe = null;
    });

    // Call the API to generate a new recipe
    try {
      final userSettings = await UserService().getUserSettings();

      final recipe = await RecipeService().generateRecipe(userSettings);
      // final recipe = Recipe(
      //   id: 1,
      //   name: "Zesty Chicken Salad",
      //   description:
      //       "A refreshing and savory salad packed with protein and fiber, great for weight loss.",
      //   instructions:
      //       "Step 1: Season the chicken breasts with salt and pepper. Step 2: Heat one tablespoon of olive oil in a pan and cook the chicken until golden brown. Step 3: In a large bowl, mix the salad greens, cucumber, cherry tomatoes, and red onion. Step 4: Slice the cooked chicken and add it to the salad mix. Step 5: In a small bowl, whisk together the remaining olive oil and vinegar. Pour the dressing over the salad and toss to combine. Serve immediately.",
      //   category: "Lunch",
      //   difficulty: "Easy",
      //   time: 30,
      //   ingredients: [
      //     "200 grams of skinless chicken breasts",
      //     "100 grams of mixed salad greens",
      //     "1 medium-sized cucumber, thinly sliced",
      //     "10 cherry tomatoes, halved",
      //     "1 medium-sized red onion, thinly sliced",
      //     "2 tablespoons of olive oil",
      //     "1 tablespoon of vinegar",
      //     "Salt and pepper to taste"
      //   ],
      //   nutrition: Nutrition(
      //     servings: 2,
      //     calories: 300,
      //     protein: 40,
      //     fat: 9,
      //     carbs: 10,
      //   ),
      // );
      setState(() {
        generatedRecipe = recipe;
      });
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Error"),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          ),
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _saveRecipe() async {
    var userId = await FlutterSecureStorage().read(key: "id");
    if (generatedRecipe != null) {
      if (await RecipeService().saveRecipe(generatedRecipe!, userId)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Recipe saved successfully!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to save recipe")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generate Recipe"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: isLoading
                ? const CircularProgressIndicator()
                : generatedRecipe == null
                    ? ElevatedButton(
                        onPressed: _generateRecipe,
                        child: const Text("Generate Recipe"),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(generatedRecipe!.name,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text("Description:\n${generatedRecipe!.description}"),
                          const SizedBox(height: 10),
                          Text(
                              "Ingredients:\n${generatedRecipe!.ingredients.join("\n")}"),
                          const SizedBox(height: 10),
                          Text("Category: ${generatedRecipe!.category}"),
                          const SizedBox(height: 10),
                          Text("Difficulty: ${generatedRecipe!.difficulty}"),
                          const SizedBox(height: 10),
                          Text("Time: ${generatedRecipe!.time} minutes"),
                          const SizedBox(height: 10),
                          Text("Nutrition Information:"),
                          Text(
                              "- Servings: ${generatedRecipe!.nutrition.servings}"),
                          Text(
                              "- Calories: ${generatedRecipe!.nutrition.calories}g"),
                          Text(
                              "- Protein: ${generatedRecipe!.nutrition.protein}g"),
                          Text("- Fat: ${generatedRecipe!.nutrition.fat}g"),
                          Text("- Carbs: ${generatedRecipe!.nutrition.carbs}g"),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: _saveRecipe,
                              child: const Text("Save Recipe"),
                            ),
                          ),
                        ],
                      )),
      ),
    );
  }
}
