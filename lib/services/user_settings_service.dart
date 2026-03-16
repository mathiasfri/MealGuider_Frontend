import 'package:mealguider/models/user_settings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserSettingsService {
  final _supabase = Supabase.instance.client;

  Future<UserSettings?> getUserSettings() async {
    final userId = _supabase.auth.currentUser!.id;

    final response = await _supabase
        .from('user_settings')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (response == null) return null;
    return UserSettings.fromJson(response);
  }

  Future<UserSettings> saveUserSettings(UserSettings settings) async {
    final response = await _supabase
        .from('user_settings')
        .upsert(settings.toJson(), onConflict: 'user_id')
        .select()
        .single();

    return UserSettings.fromJson(response);
  }
}
