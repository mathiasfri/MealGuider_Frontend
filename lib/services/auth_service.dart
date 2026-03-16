import 'package:mealguider/models/auth_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final _supabase = Supabase.instance.client;

  Future<AppUser> register(String email, String password) async {
    final response = await _supabase.auth.signUp(email: email, password: password);

    if (response.user == null) {
      throw Exception('Registration failed.');
    }

    return AppUser.fromSupabaseUser(response.user!);
  }

  Future<AppUser> login(String email, String password) async {
    final response = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception('Registration failed.');
    }

    return AppUser.fromSupabaseUser(response.user!);
  }

  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  AppUser? get currentUser {
    final user = _supabase.auth.currentUser;
    return user != null ? AppUser.fromSupabaseUser(user) : null;
  }
}
