import 'package:flutter/material.dart';
import 'package:mealguider/functionality/user/model/user.dart';
import 'package:mealguider/functionality/user/model/user_settings.dart';
import 'package:mealguider/functionality/user/service/user_service.dart';
import 'package:mealguider/utils/code_constants.dart';

class UserSettingsPage extends StatefulWidget {
  const UserSettingsPage({super.key});

  @override
  State<UserSettingsPage> createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController workoutRateController = TextEditingController();

  List<String>? genders;
  List<String>? weightGoals;
  String? gender;
  String? weightGoal;

  final List<String> selectedAllergies = [];

  @override
  void initState() {
    super.initState();

    _getEnums();
  }

  void _getEnums() async {
    List<String> gendersList = await UserService().getGenders();
    List<String> weightGoalsList = await UserService().getWeightGoals();
    setState(() {
      genders = gendersList;
      weightGoals = weightGoalsList;
    });
  }

  void _updateUserSettings() async {
    final settings = UserSettings(
      age: int.parse(ageController.text),
      height: int.parse(heightController.text),
      weight: int.parse(weightController.text),
      gender: gender ?? "UNKNOWN",
      workRate: int.parse(workoutRateController.text),
      weightGoal: weightGoal ?? "MAINTAIN",
      allergies: selectedAllergies.isEmpty ? null : selectedAllergies,
    );

    await UserService().updateUserSettings(settings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Height Input
                TextFormField(
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Height (cm)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        double.parse(value) >= 220) {
                      return 'Please enter a valid height';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Weight Input
                TextFormField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Weight (kg)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        double.parse(value) >= 300) {
                      return 'Please enter a valid weight';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Age Input
                TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        double.parse(value) >= 100) {
                      return 'Please enter a valid age';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Gender Dropdown
                DropdownButtonFormField<String>(
                  value: gender,
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(),
                  ),
                  items: genders == null
                      ? []
                      : genders!
                          .map((gender) => DropdownMenuItem(
                                value: gender,
                                child: Text(gender),
                              ))
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select your gender' : null,
                ),
                const SizedBox(height: 16),

                // Workout Rate Input
                TextFormField(
                  controller: workoutRateController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Workout Days Per Week',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        double.parse(value) > 7) {
                      return 'Please enter a valid number of workout days';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Weight Goal Dropdown
                DropdownButtonFormField<String>(
                  value: weightGoal,
                  decoration: const InputDecoration(
                    labelText: 'Weight Goal',
                    border: OutlineInputBorder(),
                  ),
                  items: weightGoals == null
                      ? []
                      : weightGoals!
                          .map((goal) => DropdownMenuItem(
                                value: goal,
                                child: Text(goal),
                              ))
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      weightGoal = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select your weight goal' : null,
                ),
                const SizedBox(height: 16),

                // Allergies Selection with Collapse Option
                ExpansionTile(
                  title: const Text("Allergies"),
                  children: _buildCollapsibleAllergies(),
                ),
                const SizedBox(height: 16),

                // Save Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Save user information
                        _updateUserSettings();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('User information saved successfully!'),
                          ),
                        );
                      }
                    },
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper for collapsible allergies
  List<Widget> _buildCollapsibleAllergies() {
    return commonAllergies
        .map((allergy) => CheckboxListTile(
              title: Text(allergy),
              value: selectedAllergies.contains(allergy),
              onChanged: (bool? selected) {
                setState(() {
                  if (selected == true) {
                    selectedAllergies.add(allergy);
                  } else {
                    selectedAllergies.remove(allergy);
                  }
                });
              },
            ))
        .toList();
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    heightController.dispose();
    weightController.dispose();
    ageController.dispose();
    workoutRateController.dispose();
    super.dispose();
  }
}
