import 'package:flutter/material.dart';
import 'sidebar.dart';
import 'bottom_navigation.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? currentBackPressTime;
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
    _timer = Timer.periodic(Duration(seconds: 4), (Timer timer) {
      if (_currentPage < 4) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel(); // Dispose the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentBackPressTime == null ||
            DateTime.now().difference(currentBackPressTime!) >
                Duration(seconds: 1)) {
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
        appBar: AppBar(
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
        ),
        body: _buildBody(),
        drawer: Sidebar(
          onItemSelected: (index) {
            setState(() {
              _navigateToSelectedPage(context, index);
            });
          },
          currentIndex: 0,
        ),
        bottomNavigationBar: BottomNavigation(
          onTabTapped: (index) {
            setState(() {
              // Handle bottom navigation item taps if needed
            });
          },
          currentIndex: 0,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/dilg-main.png',
                  width: 60.0,
                  height: 60.0,
                ),
                const SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'REPUBLIC OF THE PHILIPPINES',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Text(
                      'DEPARTMENT OF THE INTERIOR AND LOCAL GOVERNMENT',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 9,
                      ),
                    ),
                    Text(
                      'BOHOL PROVINCE',
                      style: TextStyle(
                        fontSize: 8,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            SizedBox(
              height: 250.0, // Adjust the height as needed
              child: _buildHorizontalScrollableCards(),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recently Opened Issuances',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
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
        ),
      ),
    );
  }

  Widget _buildHorizontalScrollableCards() {
    return Container(
      height: 100.0,
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        itemCount: 6, // Change the itemCount to 6 for 6 cards
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildCard('assets/amu1.png', 'Card Title 0', index);
          } else if (index == 1) {
            return _buildCard('assets/amu2.png', 'Card Title 1', index);
          } else if (index == 2) {
            return _buildCard('assets/amu3.png', 'Card Title 2', index);
          } else if (index == 3) {
            return _buildCard('assets/amu4.png', 'Card Title 3', index);
          } else if (index == 4) {
            return _buildCard('assets/amu5.png', 'Card Title 4', index);
          } else if (index == 5) {
            // Display "See More" container for index 5
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Card(
                elevation: 5.0,
                child: InkWell(
                  onTap: () {
                    // Handle "See More" click
                    print('See More clicked');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'See More',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        size: 20.0,
                        color: Colors.blue, // You can customize the color
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {}
        },
      ),
    );
  }

  Widget _buildCard(String imagePath, String title, int index) {
    return GestureDetector(
      onTap: () {
        // Handle card click
        print('Card $index clicked');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Card(
          elevation: 5.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image container
              Container(
                height: 115.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Title container
              Container(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
              // Content container
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  style: TextStyle(fontSize: 12.0),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Date container
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Date: ${DateTime.now().toString()}',
                  style: TextStyle(fontSize: 10.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

  void _navigateToSelectedPage(BuildContext context, int index) {
    // Handle navigation to selected page
  }
}
