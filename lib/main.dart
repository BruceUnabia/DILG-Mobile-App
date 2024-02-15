import 'package:flutter/material.dart';
import '../utils/routes.dart';
import '../screens/home_screen.dart';
import '../screens/search_screen.dart';
import '../screens/library_screen.dart';
import '../screens/edit_user.dart';

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
      initialRoute: Routes.login,
      routes: Routes.getRoutes(context),
      // onGenerateRoute: (settings) {
      //   // Handle unknown routes, such as pressing the back button
      //   return MaterialPageRoute(builder: (context) => const HomeScreen());
      // },
    );
  }
}

class BottomNavigationWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  BottomNavigationWidget({
    required this.currentIndex,
    required this.onTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTabTapped,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books),
          label: 'Library',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit),
          label: 'Edit User',
        ),
      ],
    );
  }
}
