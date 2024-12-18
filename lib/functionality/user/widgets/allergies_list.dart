import 'package:flutter/material.dart';
import 'package:mealguider/utils/code_constants.dart';

class AllergiesListPage extends StatefulWidget {
  const AllergiesListPage({super.key});

  @override
  _AllergiesListPageState createState() => _AllergiesListPageState();
}

class _AllergiesListPageState extends State<AllergiesListPage> {
  final List<String> selectedAllergies = [];

  void toggleAllergy(String allergy) {
    setState(() {
      if (selectedAllergies.contains(allergy)) {
        selectedAllergies.remove(allergy);
      } else {
        selectedAllergies.add(allergy);
      }
    });
  }

  void saveAllergies() {
    // Handle saving allergies, e.g., send to the backend
    print("Selected Allergies: $selectedAllergies");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Allergies")),
      body: ListView(
        children: commonAllergies.map((allergy) {
          return CheckboxListTile(
            title: Text(allergy),
            value: selectedAllergies.contains(allergy),
            onChanged: (bool? value) {
              toggleAllergy(allergy);
            },
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: saveAllergies,
        label: Text("Save"),
        icon: Icon(Icons.save),
      ),
    );
  }
}
