import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/routes.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import 'dart:async';

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
      home: FutureBuilder<bool>(
        future: _checkAuthenticationState(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            bool isAuthenticated = snapshot.data ?? false;
            return isAuthenticated
                ? const HomeScreen()
                : LoginScreen(onLogin: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  });
          } else {
            return const CircularProgressIndicator(); // or another loading indicator
          }
        },
      ),
      routes: Routes.getRoutes(context),
    );
  }

  static Future<bool> _checkAuthenticationState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isAuthenticated = prefs.getBool('isAuthenticated');
    return isAuthenticated ?? false;
  }
}
