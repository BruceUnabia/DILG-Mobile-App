import 'package:flutter/material.dart';
import '../utils/routes.dart';
import '../screens/home_screen.dart';

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
      initialRoute: Routes.introsection, // Set the initial route
      routes: Routes.getRoutes(context),
      onGenerateRoute: (settings) {
        // Handle unknown routes, such as pressing the back button
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      },
    );
  }
}
