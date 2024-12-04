import 'package:flutter/material.dart';
import 'package:mealguider/functionality/recipes/pages/recipe_list_page.dart';
import 'package:mealguider/functionality/user/pages/user_settings.dart';
import 'package:mealguider/navigation/pages/home_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(118, 0, 0, 0),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.supervised_user_circle),
            title: const Text('User Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserSettings()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.food_bank),
            title: const Text('List of Recipes'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecipesList()),
              );
            },
          ),
        ],
      ),
    );
  }
}
