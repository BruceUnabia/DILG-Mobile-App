// import 'package:flutter/material.dart';
// import 'home_screen.dart';
// import 'search_screen.dart';
// import 'library_screen.dart';
// import 'edit_user.dart';

// class CustomePageRoute<T> extends PageRouteBuilder<T> {
//   final Widget page;

//   CustomePageRoute({required this.page})
//       : super(
//           pageBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//           ) =>
//               page,
//           transitionsBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//             Widget child,
//           ) {
//             const begin = 0.0;
//             const end = 1.0;
//             const curve = Curves.easeInOut;

//             var tween = Tween(begin: begin, end: end).chain(
//               CurveTween(curve: curve),
//             );

//             var fadeAnimation = animation.drive(tween);

//             return FadeTransition(
//               opacity: fadeAnimation,
//               child: child,
//             );
//           },
//         );
// }

// void navigateToSelectedPage(BuildContext context, int index) {
//   Widget page;

//   switch (index) {
//     case 0:
//       page = HomeScreen();
//       break;
//     case 1:
//       page = SearchScreen();
//       break;
//     case 2:
//       page = LibraryScreen();
//       break;
//     case 3:
//       page = EditUser();
//       break;
//     // Add more cases if needed

//     default:
//       page = HomeScreen();
//   }

//   Navigator.of(context).push(CustomePageRoute(page: page));
// }
