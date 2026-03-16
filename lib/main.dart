import 'package:flutter/material.dart';
import 'package:mealguider/navigation/pages/home_screen.dart';
import 'package:mealguider/navigation/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
      url: 'https://gtdorwjdbsfusqkhzyze.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd0ZG9yd2pkYnNmdXNxa2h6eXplIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzM2NTU5MDUsImV4cCI6MjA4OTIzMTkwNX0.MtToUxDfu8nlTlSUdCvlf3yip36kSZ56XG_b43nVl7U');

  runApp(const MainApp());
}

final supabase = Supabase.instance.client;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Diet Planner App',
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.green,
          scaffoldBackgroundColor: const Color(0xFF121212),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1F1F1F),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          drawerTheme: const DrawerThemeData(
            backgroundColor: Color(0xFF1E1E1E),
          ),
          iconTheme: const IconThemeData(color: Colors.white70),
          listTileTheme: const ListTileThemeData(
            iconColor: Colors.white70,
            textColor: Colors.white70,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
              textStyle:
                  const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        home: supabase.auth.currentSession != null
            ? const HomeScreen()
            : const LoginPage());
  }
}
