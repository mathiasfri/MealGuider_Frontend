import 'package:mealguider/functionality/user/model/user.dart';

class UserSettings {
  final int id;
  final int age;
  final int height;
  final int weight;
  final String gender;
  final int workRate;
  final int weightGoal;
  final User? user;

  UserSettings({
    required this.id,
    required this.age,
    required this.height,
    required this.weight,
    required this.gender,
    required this.workRate,
    required this.weightGoal,
    this.user,
  });

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      id: json['id'],
      age: json['age'],
      height: json['height'],
      weight: json['weight'],
      gender: json['gender'],
      workRate: json['workRate'],
      weightGoal: json['weightGoal'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'height': height,
      'weight': weight,
      'gender': gender,
      'workRate': workRate,
      'weightGoal': weightGoal,
      'user': user!.toJson(),
    };
  }
}
