import 'edit_user.dart';
import 'package:flutter/material.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'details_screen.dart';
import 'bottom_navigation.dart';
import 'search_screen.dart';
import 'library_screen.dart';
import 'home_screen.dart';
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
    return Scaffold(
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
    );
  }

  Widget _buildBody() {
    TextEditingController searchController = TextEditingController();

    return SingleChildScrollView(
      child: Column(
        children: [
          // Filter Category Dropdown
          Container(
            margin: EdgeInsets.only(bottom: 5.0),
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
                SizedBox(height: 8.0),
                Container(
                  margin: EdgeInsets.only(top: 0.1, bottom: 0.1),
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
                              Icon(Icons.arrow_downward,
                                  color: Colors.blue[900]),
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
            width: 400,
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
            animationDurationInMilli: 1000,
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
                SizedBox(height: 5.0),
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
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 237, 229, 229),
                                  width: 1.0),
                            ),
                          ),
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

  void _navigateToSelectedPage(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          switch (index) {
            case 0:
              return HomeScreen();
            case 1:
              return SearchScreen();
            case 2:
              return LibraryScreen();
            case 3:
              return EditUser();
            default:
              return LatestIssuances(); // Fallback to the current page
          }
        },
      ),
    );
  }
}
