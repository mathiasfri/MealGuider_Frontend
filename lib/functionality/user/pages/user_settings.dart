import 'package:flutter/material.dart';
import 'package:mealguider/functionality/user/service/user_service.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
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

  @override
  void initState() {
    super.initState();

    // Initialize dropdown values
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
                const SizedBox(height: 24),

                // Save Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Save user information
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
