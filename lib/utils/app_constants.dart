class AppConstants {
  static const List<String> commonAllergies = [
    "Peanuts",
    "Tree Nuts",
    "Milk",
    "Eggs",
    "Fish",
    "Shellfish",
    "Wheat",
    "Soy",
    "Sesame",
    "Gluten",
    "Lupin",
    "Celery",
    "Mustard",
    "Sulphites",
    "Crustaceans",
    "Mollusks",
    "Corn",
    "Strawberries",
    "Kiwi",
    "Tomatoes",
  ];

  static const List<String> difficulties = ['Easy', 'Medium', 'Hard'];

  static const List<String> genders = ['Male', 'Female', 'Other'];

  static const List<String> weightGoals = [
    'Lose Weight',
    'Maintain Weight',
    'Gain Weight'
  ];

  static const List<String> categories = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snack',
    'Dessert'
  ];

  String capitalize(String s) =>
      s[0].toUpperCase() + s.substring(1).toLowerCase();
}
