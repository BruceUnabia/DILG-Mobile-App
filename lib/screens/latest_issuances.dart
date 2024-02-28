import 'package:flutter/material.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'details_screen.dart';
import 'bottom_navigation.dart';
import 'sidebar.dart';

class LatestIssuances extends StatefulWidget {
  @override
  _LatestIssuancesState createState() => _LatestIssuancesState();
}

class _LatestIssuancesState extends State<LatestIssuances> {
  List<String> categories = [
    'All Outcome Area',
    'ACCOUNTABLE, TRANSPARENT, PARTICIPATIVE, AND EFFECTIVE LOCAL GOVERNANCE',
    'PEACEFUL, ORDERLY AND SAFE LGUS STRATEGIC PRIORITIES',
    'SOCIALLY PROTECTIVE LGUS',
    'ENVIRONMENT-PROTECTIVE, CLIMATE CHANGE ADAPTIVE AND DISASTER RESILIENT LGUS',
    'BUSINESS-FRIENDLY AND COMPETITIVE LGUS',
    'STRENGTHENING OF INTERNAL GOVERNANCE',
  ];
  String selectedCategory = 'All Outcome Area'; // Default selection

  TextEditingController _searchController = TextEditingController();
  List<String> _recentSearches = [""];

  int _currentIndex = 1;
  List<String> _drawerMenuItems = [
    'Home',
    'Search',
    'Library',
    'View Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Scaffold.of(context).isDrawerOpen) {
          Navigator.of(context).pop();
          return false; // Prevent back navigation
        } else {
          // Navigate back to the home page when the back button is pressed
          Navigator.pushReplacementNamed(context, '/home');
          return Future.value(false); // Prevent popping
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Latest Issuances',
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
          backgroundColor: Colors.blue[900],
        ),
        body: _buildBody(),
        drawer: Sidebar(
          currentIndex: 1,
          onItemSelected: (index) {
            _navigateToSelectedPage(context, index);
          },
        ),
        bottomNavigationBar: BottomNavigation(
          currentIndex: 0,
          onTabTapped: (index) {
            setState(() {
              // _currentIndex = index;
            });
            // Handle navigation or other actions here
          },
        ),
      ),
    );
  }

  Widget _buildBody() {
    TextEditingController searchController = TextEditingController();

    return SingleChildScrollView(
      child: Column(
        children: [
          // Filter Category Dropdown
          Container(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Outcome Area/Program: ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.0),
                  child: DropdownButton<String>(
                    value: selectedCategory,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedCategory = newValue;
                        });
                      }
                    },
                    items: categories
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Row(
                            children: [
                              Text(
                                '\u2217', // Asterisk
                                style: TextStyle(
                                    fontSize: 24, color: Colors.blue[900]),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                child: Text(
                                  value,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          // Search Input
          AnimSearchBar(
            width: 300,
            onSubmitted: (query) {
              print('Search submitted: $query');
            },
            onSuffixTap: () {
              setState(() {
                _searchController.clear();
              });
            },
            color: Colors.blue[400]!,
            helpText: "Search...",
            autoFocus: true,
            closeSearchOnSuffixTap: true,
            animationDurationInMilli: 1200,
            rtl: true,
            textController: _searchController,
          ),

          // Sample Table Section
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Latest',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 2,
                  height: 2,
                ),
                for (int index = 0; index < 11; index++)
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          _navigateToDetailsPage(
                            context,
                            'Title $index is a very long title that might overflow and needs to be truncated',
                            'content $index',
                            '${index + 1}',
                            '${DateTime.now().subtract(Duration(days: index)).toString().split(' ')[0]}',
                          );
                        },
                        child: Container(
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Icon(Icons.article, color: Colors.blue[900]),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Card Title $index is a very long title that might overflow and needs to be truncated',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(height: 4.0),
                                        Text(
                                          'Ref #${index + 1}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Text(
                                    '${DateTime.now().subtract(Duration(days: index)).toString().split(' ')[0]}',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToDetailsPage(
    BuildContext context,
    String title,
    String content,
    String referenceNo,
    String date,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsScreen(
          title: title,
          content: content,
          referenceNo: referenceNo,
          date: date,
        ),
      ),
    );
  }

  void _handleBackButton(BuildContext context) {
    if (Scaffold.of(context).isDrawerOpen) {
      // If the drawer is open, close it
      Navigator.of(context).pop();
    } else {
      // Otherwise, navigate back to the home page
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  void _navigateToSelectedPage(BuildContext context, int index) {
    // Close the drawer
    Navigator.of(context).pop();

    // Navigate to the selected page
    Navigator.pushReplacementNamed(context, '/home');

    // Pop all routes until the home page is reached
    Navigator.popUntil(context, ModalRoute.withName('/home'));
  }
}
