class UserSettings {
  final int? id;
  final int age;
  final int height;
  final int weight;
  final String gender;
  final int workRate;
  final String weightGoal;
  final List<String>? allergies;

  UserSettings({
    this.id,
    required this.age,
    required this.height,
    required this.weight,
    required this.gender,
    required this.workRate,
    required this.weightGoal,
    this.allergies,
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
      allergies: json['allergies'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'age': age,
      'height': height,
      'weight': weight,
      'gender': gender,
      'workRate': workRate,
      'weightGoal': weightGoal,
      'allergies': allergies,
    };
  }
}
