// ignore_for_file: avoid_print

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mealguider/functionality/user/model/user_settings.dart';
import 'dart:convert';

import 'package:mealguider/utils/constants.dart';

class UserService {
  Future<List<String>> getGenders() async {
    try {
      Uri url = Uri.parse("$API_URL/enum/genders");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<String> listGenders = jsonDecode(response.body).cast<String>();
        return listGenders;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<String>> getWeightGoals() async {
    try {
      Uri url = Uri.parse("$API_URL/enum/weightGoals");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<String> listGenders = jsonDecode(response.body).cast<String>();
        return listGenders;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<void> updateUserSettings(UserSettings userSettings) async {
    var id = await FlutterSecureStorage().read(key: 'id');

    try {
      Uri url = Uri.parse("$API_URL/userSettings/save/$id");

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userSettings.toJson()),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("User settings updated successfully");
      } else {
        print("Failed to update user settings: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<UserSettings> getUserSettings() async {
    var id = await FlutterSecureStorage().read(key: 'id');

    try {
      Uri url = Uri.parse("$API_URL/userSettings/$id");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return UserSettings.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to get user settings: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get user settings: $e');
    }
  }
}
