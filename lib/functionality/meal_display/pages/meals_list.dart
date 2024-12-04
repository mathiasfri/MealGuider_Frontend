import 'package:flutter/material.dart';

class MealsList extends StatelessWidget {
  const MealsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meals List'),
      ),
      body: const Center(
        child: Text(
          'List of meals will be displayed here.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
