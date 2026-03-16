class EnumHelpers {
  // Gender
  static const Map<String, String> _genderDisplayMap = {
    'MALE': 'Male',
    'FEMALE': 'Female',
    'OTHER': 'Other',
  };

  static String? genderToDisplay(String? dbValue) {
    if (dbValue == null) return null;
    return _genderDisplayMap[dbValue.toUpperCase()];
  }

  static String? genderToDb(String? displayValue) {
    if (displayValue == null) return null;
    return _genderDisplayMap.entries
        .firstWhere((e) => e.value == displayValue,
            orElse: () => const MapEntry('', ''))
        .key;
  }

  // Weight Goal
  static const Map<String, String> _weightGoalDisplayMap = {
    'LOSE_WEIGHT': 'Lose Weight',
    'MAINTAIN_WEIGHT': 'Maintain Weight',
    'GAIN_WEIGHT': 'Gain Weight',
  };

  static String? weightGoalToDisplay(String? dbValue) {
    if (dbValue == null) return null;
    return _weightGoalDisplayMap[dbValue.toUpperCase()];
  }

  static String? weightGoalToDb(String? displayValue) {
    if (displayValue == null) return null;
    return _weightGoalDisplayMap.entries
        .firstWhere((e) => e.value == displayValue,
            orElse: () => const MapEntry('', ''))
        .key;
  }
}