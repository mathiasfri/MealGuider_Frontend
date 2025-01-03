import 'package:flutter/material.dart';
import 'package:mealguider/functionality/authentication/service/auth_service.dart';
import 'package:mealguider/navigation/pages/home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  void _loginWithGoogle() async {
    try {
      final token = await authService.loginWithGoogle();
      _showSuccess('Google', token!);
    } catch (e) {
      _showError('Google', e.toString());
    }
  }

  void _loginWithFacebook() async {
    try {
      final token = await authService.loginWithFacebook();
      _showSuccess('Facebook', token!);
    } catch (e) {
      _showError('Facebook', e.toString());
    }
  }

  void _loginWithGitHub() async {
    try {
      final token = await authService.loginWithGitHub();
      _showSuccess('Microsoft', token!);
    } catch (e) {
      _showError('Microsoft', e.toString());
    }
  }

  void _loginWithEmailPassword() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      final success = await authService.loginWithEmailPassword(email, password);
      if (success) {
        _showSuccess('Email/Password', 'Login successful');
      }
    } catch (e) {
      _showError('Email/Password', e.toString());
    }
  }

  void _registerWithEmailPassword() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      final success =
          await authService.createUserWithEmailAndPassword(email, password);
      if (success) {
        _showSuccess('Email/Password', 'Registration successful');
      }
    } catch (e) {
      _showError('Email/Password', e.toString());
    }
  }

  void _showSuccess(String provider, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$provider Login Successful: $message')),
    );
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  void _showError(String provider, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$provider Login Failed: $error')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Login',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loginWithEmailPassword,
              child: const Text('Login'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _registerWithEmailPassword,
              child: const Text('Register'),
            ),
            const SizedBox(height: 20),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     IconButton(
            //       onPressed: _loginWithGoogle,
            //       icon: const Icon(Icons.g_mobiledata),
            //       iconSize: 50,
            //     ),
            //     const SizedBox(height: 10),
            //     IconButton(
            //       onPressed: _loginWithFacebook,
            //       icon: const Icon(Icons.facebook),
            //       color: Colors.blue,
            //       iconSize: 50,
            //     ),
            //     const SizedBox(height: 10),
            //     IconButton(
            //       onPressed: _loginWithGitHub,
            //       icon: const Icon(Icons.mobile_friendly_outlined),
            //       iconSize: 50,
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
