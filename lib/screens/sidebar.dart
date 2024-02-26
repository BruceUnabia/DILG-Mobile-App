import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'latest_issuances.dart';
import 'joint_circulars.dart';
import 'memo_circulars.dart';
import 'presidential_directives.dart';
import 'draft_issuances.dart';
import 'republic_acts.dart';
import 'legal_opinions.dart';
import 'home_screen.dart';
import 'about_screen.dart';
import 'developers_screen.dart';
import 'login_screen.dart';

class Sidebar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemSelected;

  const Sidebar({required this.currentIndex, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.blue[900],
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue[900]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/dilg-main.png',
                    width: 70.0,
                    height: 70.0,
                  ),
                  SizedBox(width: 8.0),
                  const Text(
                    'DILG - BOHOL PROVINCE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            _buildSidebarItem(Icons.home, 'Home', 0, context),
            _buildSidebarItem(Icons.article, 'Latest Issuances', 1, context),
            _buildSidebarItem(
                Icons.compare_arrows, 'Joint Circulars', 2, context),
            _buildSidebarItem(Icons.note, 'Memo Circulars', 3, context),
            _buildSidebarItem(
                Icons.gavel, 'Presidential Directives', 4, context),
            _buildSidebarItem(Icons.drafts, 'Draft Issuances', 5, context),
            _buildSidebarItem(
                Icons.account_balance, 'Republic Acts', 6, context),
            _buildSidebarItem(
                Icons.library_books, 'Legal Opinions', 7, context),
            Divider(color: Colors.white),
            _buildSidebarItem(Icons.info, 'About', 8, context),
            _buildSidebarItem(Icons.people, 'Developers', 9, context),
            Divider(color: Colors.white),
            _buildSidebarItem(Icons.exit_to_app, 'Logout', 10, context),
          ],
        ),
      ),
    );
  }

  Widget _getPageByIndex(int index, {BuildContext? context}) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return WillPopScope(
          onWillPop: () async {
            Navigator.pushReplacementNamed(context!, '/home');
            return Future.value(false); // Prevent popping
          },
          child: LatestIssuances(),
        );
      case 2:
        return WillPopScope(
          onWillPop: () async {
            Navigator.pushReplacementNamed(context!, '/home');
            return Future.value(false); // Prevent popping
          },
          child: JointCirculars(),
        );
      case 3:
        return WillPopScope(
          onWillPop: () async {
            Navigator.pushReplacementNamed(context!, '/home');
            return Future.value(false); // Prevent popping
          },
          child: MemoCirculars(),
        );
      case 4:
        return WillPopScope(
          onWillPop: () async {
            Navigator.pushReplacementNamed(context!, '/home');
            return Future.value(false); // Prevent popping
          },
          child: PresidentialDirectives(),
        );
      case 5:
        return WillPopScope(
          onWillPop: () async {
            Navigator.pushReplacementNamed(context!, '/home');
            return Future.value(false); // Prevent popping
          },
          child: DraftIssuances(),
        );
      case 6:
        return WillPopScope(
          onWillPop: () async {
            Navigator.pushReplacementNamed(context!, '/home');
            return Future.value(false); // Prevent popping
          },
          child: RepublicActs(),
        );
      case 7:
        return WillPopScope(
          onWillPop: () async {
            Navigator.pushReplacementNamed(context!, '/home');
            return Future.value(false); // Prevent popping
          },
          child: LegalOpinions(),
        );
      case 8:
        return WillPopScope(
          onWillPop: () async {
            Navigator.pushReplacementNamed(context!, '/home');
            return Future.value(false); // Prevent popping
          },
          child: About(),
        );
      case 9:
        return WillPopScope(
          onWillPop: () async {
            Navigator.pushReplacementNamed(context!, '/home');
            return Future.value(false); // Prevent popping
          },
          child: Developers(),
        );
      case 10:
        return LoginScreen(
          onLogin: () {
            Navigator.pop(context!); // Close the sidebar
            Navigator.pushReplacementNamed(
                context, '/login'); // Navigate to the home screen
          },
        );
      default:
        return Container();
    }
  }

  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.of(context)
        .pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (Route<dynamic> route) => false,
    )
        .then((value) {
      onItemSelected(0);
    });
  }

  Widget _buildSidebarItem(
      IconData icon, String title, int index, BuildContext context) {
    return InkWell(
      onTap: () async {
        if (index == 10) {
          // Logout action
          await _handleLogout(context);
        }

        onItemSelected(index);
        Navigator.of(context).pop();
        _navigateToPage(context, _getPageByIndex(index, context: context));
      },
      child: ListTile(
        title: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              title,
              style: TextStyle(
                color: currentIndex == index
                    ? Colors.white
                    : Colors.white.withOpacity(0.5),
                fontWeight:
                    currentIndex == index ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isAuthenticated', false);
  }
}
