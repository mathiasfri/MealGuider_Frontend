import 'package:flutter/material.dart';
import 'package:mealguider/navigation/drawer.dart';
import 'package:mealguider/navigation/pages/settings_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Diet Planner App'), actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
            icon: const Icon(Icons.settings)),
      ]),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text(
          'Welcome to the Diet Planner App',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
