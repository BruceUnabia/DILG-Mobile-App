import 'package:flutter/material.dart';

import 'sidebar.dart';

import 'bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  // List<String> _drawerMenuItems = [
  //   'Home',
  //   'Search',
  //   'Library',
  //   'View Profile',
  // ];

  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return false;
        } else if (currentBackPressTime == null ||
            DateTime.now().difference(currentBackPressTime!) >
                Duration(seconds: 2)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Press back again to exit'),
              duration: Duration(seconds: 2),
            ),
          );
          currentBackPressTime = DateTime.now();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: _currentIndex == 0
            ? AppBar(
                title: Text(
                  'Home',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                leading: Builder(
                  builder: (context) => IconButton(
                    icon: Icon(Icons.menu, color: Colors.white),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
                automaticallyImplyLeading: true,
                backgroundColor: Colors.blue[900],
              )
            : null,
        // Only show AppBar for HomeScreen
        body: _buildBody(),
        drawer: Sidebar(
          currentIndex: _currentIndex,
          onItemSelected: (index) {
            setState(() {
              _navigateToSelectedPage(context, index);
            });
          },
        ),
        bottomNavigationBar: BottomNavigation(
          currentIndex: 0,
          onTabTapped: (index) {
            setState(() {
              // _currentIndex = index.clamp(0, _drawerMenuItems.length - 1);
            });
          },
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        // Home Screen
        return ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Center(
              child: Image.asset(
                'assets/dilg-main.png',
                width: 200.0,
                height: 200.0,
              ),
            ),
            const SizedBox(height: 16.0),
            Divider(
              color: Colors.grey,
              thickness: 2,
              height: 2,
            ),
            const Text(
              'Recently Opened Issuances',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRecentIssuances(),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        );
      default:
        return Container();
    }
  }

  Widget _buildRecentIssuances() {
    List<Map<String, String>> recentIssuances = [
      {'title': 'Issuance 1', 'subtitle': 'Subtitle for Issuance 1'},
      {'title': 'Issuance 2', 'subtitle': 'Subtitle for Issuance 2'},
      {'title': 'Issuance 3', 'subtitle': 'Subtitle for Issuance 3'},
      {'title': 'Issuance 4', 'subtitle': 'Subtitle for Issuance 4'},
      {'title': 'Issuance 5', 'subtitle': 'Subtitle for Issuance 5'},
      {'title': 'Issuance 6', 'subtitle': 'Subtitle for Issuance 6'},
      {'title': 'Issuance 7', 'subtitle': 'Subtitle for Issuance 7'},
      {'title': 'Issuance 8', 'subtitle': 'Subtitle for Issuance 8'},
      {'title': 'Issuance 9', 'subtitle': 'Subtitle for Issuance 9'},
      {'title': 'Issuance 10', 'subtitle': 'Subtitle for Issuance 10'},
    ];

    return Column(
      children: recentIssuances.take(10).map((issuance) {
        return Column(
          children: [
            ListTile(
              title: Text(issuance['title']!),
              subtitle: Text(issuance['subtitle']!),
              trailing: ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                child: Text('View'),
              ),
            ),
            const Divider(),
          ],
        );
      }).toList(),
    );
  }
}

void _navigateToSelectedPage(BuildContext context, int index) {}
