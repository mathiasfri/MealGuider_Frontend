class UserSettings {
  final int? id;
  final String userId;
  final int age;
  final int weight;
  final int height;
  final String? gender;
  final int workoutRate;
  final String? weightGoal;
  final List<String> allergies;

  UserSettings({
    this.id,
    required this.userId,
    required this.age,
    required this.weight,
    required this.height,
    this.gender,
    required this.workoutRate,
    this.weightGoal,
    this.allergies = const [],
  });

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      id: json['id'],
      userId: json['user_id'],
      age: json['age'] ?? 0,
      weight: json['weight'] ?? 0,
      height: json['height'] ?? 0,
      gender: json['gender'],
      workoutRate: json['workout_rate'] ?? 0,
      weightGoal: json['weight_goal'],
      allergies: List<String>.from(json['allergies'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'age': age,
      'weight': weight,
      'height': height,
      'gender': gender?.toUpperCase(),
      'workout_rate': workoutRate,
      'weight_goal': weightGoal?.toUpperCase().replaceAll(' ', '_'),
      'allergies': allergies,
    };
  }
}