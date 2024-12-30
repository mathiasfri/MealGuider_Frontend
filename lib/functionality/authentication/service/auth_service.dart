// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mealguider/functionality/authentication/service/model/auth_user.dart';
import 'package:mealguider/utils/constants.dart';
import 'package:oauth2_client/github_oauth2_client.dart';
import 'package:oauth2_client/google_oauth2_client.dart';
import 'package:oauth2_client/facebook_oauth2_client.dart';

class AuthService {
  Future<String?> loginWithGoogle() async {
    final client = GoogleOAuth2Client(
      redirectUri: REDIRECT_URI,
      customUriScheme: APP_SCHEME,
    );

    try {
      final token = await client.getTokenWithAuthCodeFlow(
        clientId: GOOGLE_AUTH,
        scopes: ['openid', 'email', 'profile'],
      );
      return token.accessToken;
    } catch (e) {
      throw Exception('Google login failed: $e');
    }
  }

  Future<String?> loginWithFacebook() async {
    final client = FacebookOAuth2Client(
      redirectUri: REDIRECT_URI,
      customUriScheme: APP_SCHEME,
    );

    try {
      final token = await client.getTokenWithAuthCodeFlow(
        clientId: FACEBOOK_AUTH,
        clientSecret: '',
        scopes: ['email', 'public_profile'],
      );
      return token.accessToken;
    } catch (e) {
      throw Exception('Facebook login failed: $e');
    }
  }

  Future<String?> loginWithGitHub() async {
    final client = GitHubOAuth2Client(
      redirectUri: REDIRECT_URI,
      customUriScheme: APP_SCHEME,
    );

    try {
      final token = await client.getTokenWithAuthCodeFlow(
        clientId: GITHUB_AUTH,
        clientSecret: '',
        scopes: ['User.Read'],
      );
      return token.accessToken;
    } catch (e) {
      throw Exception('GitHub login failed: $e');
    }
  }

  Future<bool> loginWithEmailPassword(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email or password cannot be empty');
    }

    try {
      Uri url = Uri.parse("$API_URL/user/login");

      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'email': email, 'password': password}));

      print("Response: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = jsonDecode(response.body);
        AuthUser authUser = AuthUser.fromMap(responseData);
        var id = authUser.id.toString();
        await FlutterSecureStorage().write(key: 'id', value: id);

        print("User logged in successfully");
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
    return true;
  }

  Future<bool> createUserWithEmailAndPassword(
      String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email or password cannot be empty');
    }

    try {
      Uri url = Uri.parse("$API_URL/user/register");

      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'email': email, 'password': password}));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("User created successfully");
      } else {
        throw Exception('Failed to create user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
    return true;
  }
}
