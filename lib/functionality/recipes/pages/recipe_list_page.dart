import 'package:flutter/material.dart';
import 'package:mealguider/functionality/recipes/model/recipe.dart';
import 'package:mealguider/functionality/recipes/widgets/recipe_card.dart';

class RecipesList extends StatelessWidget {
  RecipesList({super.key});

  final List<Recipe> recipes = [
    // Mock data
    Recipe(
      id: 1,
      name: "Spaghetti Carbonara",
      category: "Italian",
      difficulty: "Medium",
      time: 30,
      nutrition: Nutrition(
        servings: 2,
        calories: 600,
        protein: 25,
        fat: 30,
        carbs: 70,
      ),
    ),
    Recipe(
      id: 2,
      name: "Chicken Salad",
      category: "Healthy",
      difficulty: "Easy",
      time: 20,
      nutrition: Nutrition(
        servings: 3,
        calories: 350,
        protein: 30,
        fat: 15,
        carbs: 20,
      ),
    ),
  ];

  void _deleteRecipe(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Recipe"),
        content:
            Text("Are you sure you want to delete '${recipes[index].name}'?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              recipes.removeAt(index); // Remove the recipe from the list
              Navigator.pop(context); // Close dialog
            },
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _downloadRecipe(BuildContext context, Recipe recipe) {
    // Simulate downloading the recipe (you can replace this with real functionality)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Downloading '${recipe.name}'...")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipes"),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return Dismissible(
            key: Key(recipe.id.toString()),
            background: Container(
              color: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: const Row(
                children: [
                  Icon(Icons.delete, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    "Delete",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            secondaryBackground: Container(
              color: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerRight,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Download",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.download, color: Colors.white),
                ],
              ),
            ),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                // Handle Delete Confirmation
                return await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Delete Recipe"),
                    content: Text("Do you want to delete '${recipe.name}'?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false); // Do not dismiss
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, true); // Confirm dismissal
                        },
                        child: const Text(
                          "Delete",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (direction == DismissDirection.endToStart) {
                // Handle Download
                _downloadRecipe(context, recipe);
                return false; // Prevent dismissal on download
              }
              return false; // Default case
            },
            onDismissed: (direction) {
              if (direction == DismissDirection.startToEnd) {
                // Perform deletion only if confirmDismiss allows it
                _deleteRecipe(context, index);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Recipe '${recipe.name}' deleted.")),
                );
              }
            },
            child: RecipeCard(recipe: recipe),
          );
        },
      ),
    );
  }
}
