import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mealguider/functionality/recipes/model/recipe.dart';
import 'package:mealguider/functionality/recipes/service/recipe_service.dart';
import 'package:mealguider/functionality/recipes/widgets/recipe_card.dart';

class RecipesList extends StatefulWidget {
  const RecipesList({super.key});

  @override
  State<RecipesList> createState() => _RecipesListState();
}

class _RecipesListState extends State<RecipesList> {
  // final List<Recipe> recipes = [
  //   // Sample data
  //   Recipe(
  //     id: 1,
  //     name: "Spaghetti Bolognese",
  //     description: "A classic Italian pasta dish",
  //     instructions:
  //         "1. Boil water\n2. Add spaghetti\n3. Cook for 10 minutes\n4. Heat tomato sauce\n5. Brown ground beef\n6. Combine and serve",
  //     category: "Pasta",
  //     difficulty: "Easy",
  //     time: 30,
  //     ingredients: ["Spaghetti", "Tomato Sauce", "Ground Beef"],
  //     nutrition: Nutrition(
  //       servings: 4,
  //       calories: 500,
  //       protein: 20,
  //       fat: 10,
  //       carbs: 80,
  //     ),
  //   ),
  //   Recipe(
  //     id: 2,
  //     name: "Chicken Stir-Fry",
  //     description: "A quick and healthy meal",
  //     instructions:
  //         "1. Heat oil in a pan\n2. Add chicken and stir-fry\n3. Add vegetables\n4. Add sauce\n5. Serve over rice",
  //     category: "Asian",
  //     difficulty: "Medium",
  //     time: 20,
  //     ingredients: ["Chicken", "Vegetables", "Soy Sauce"],
  //     nutrition: Nutrition(
  //       servings: 2,
  //       calories: 400,
  //       protein: 30,
  //       fat: 15,
  //       carbs: 50,
  //     ),
  //   ),
  // ];

  List<Recipe> recipes = [];

  @override
  void initState() {
    super.initState();
    _getRecipes();
  }

  Future<void> _getRecipes() async {
    var userId = await FlutterSecureStorage().read(key: 'id');

    List<Recipe> recipes = await RecipeService().getRecipes(userId);

    if (recipes.isNotEmpty) {
      setState(() {
        this.recipes = recipes;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No recipes found.")),
      );
    }
  }

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
                          Navigator.pop(context, false);
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, true);
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
                _downloadRecipe(context, recipe);
                return false;
              }
              return false;
            },
            onDismissed: (direction) {
              if (direction == DismissDirection.startToEnd) {
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
