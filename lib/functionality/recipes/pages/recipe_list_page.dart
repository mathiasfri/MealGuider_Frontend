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

  void _deleteRecipe(BuildContext context, int index) async {
    try {
      // Call the deleteRecipe function to delete from the backend
      await RecipeService().deleteRecipe(recipes[index].id!);

      // Remove the recipe locally
      setState(() {
        recipes.removeAt(index);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Recipe '${recipes[index].name}' deleted.")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete recipe: $e')),
      );
    }
  }

  void _downloadRecipe(BuildContext context, Recipe recipe) async {
    try {
      await RecipeService().downloadRecipe(recipe.id!, recipe.name);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Downloaded '${recipe.name}' PDF successfully.")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download recipe: $e')),
      );
    }
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
                final shouldDelete = await showDialog(
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

                if (shouldDelete == true) {
                  _deleteRecipe(context, index);
                  return true;
                }
              } else if (direction == DismissDirection.endToStart) {
                _downloadRecipe(context, recipe);
                return false;
              }
              return false;
            },
            child: RecipeCard(recipe: recipe),
          );
        },
      ),
    );
  }
}
