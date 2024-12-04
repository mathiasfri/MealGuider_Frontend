// ignore_for_file: avoid_print

import 'package:eksamen/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
}
