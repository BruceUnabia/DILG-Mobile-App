import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const MyAppWrapper(),
      routes: {
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}

class MyAppWrapper extends StatelessWidget {
  const MyAppWrapper({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkAuthenticationState(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          bool isAuthenticated = snapshot.data ?? false;
          if (isAuthenticated) {
            return const HomeScreen();
          } else {
            return LoginScreen(
              onLogin: () {
                // Triggered when the user successfully logs in
                Navigator.pushReplacementNamed(context, '/home');
              },
            );
          }
        } else {
          return const HomeScreen();
        }
      },
    );
  }

  Future<bool> _checkAuthenticationState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isAuthenticated = prefs.getBool('isAuthenticated') ?? false;

    // If the app is not authenticated, clear the saved authentication state
    if (!isAuthenticated) {
      prefs.remove('isAuthenticated');
    }

    return isAuthenticated;
  }
}
