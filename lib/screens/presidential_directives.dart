import 'package:flutter/material.dart';
import 'sidebar.dart';
import 'details_screen.dart';
import 'bottom_navigation.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

class PresidentialDirectives extends StatefulWidget {
  @override
  _PresidentialDirectivesState createState() => _PresidentialDirectivesState();
}

class _PresidentialDirectivesState extends State<PresidentialDirectives> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Presidential Directives',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
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
              animationDurationInMilli: 1000,
              rtl: true,
              textController: _searchController,
            ),
            _buildTable(),
          ],
        ),
      ),
      drawer: Sidebar(
        currentIndex: 4, // Adjust the index based on your sidebar menu
        onItemSelected: (index) {
          // Handle item selection if needed
          Navigator.pop(context); // Close the drawer after handling selection
        },
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: 0, // Set the current index accordingly
        onTabTapped: (index) {
          // Handle navigation if needed
        },
      ),
    );
  }

  Widget _buildTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'Latest',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Divider(
          color: Colors.grey,
          thickness: 2,
          height: 2,
        ),
        for (int index = 0; index < 11; index++)
          InkWell(
            onTap: () {
              _navigateToDetailsPage(
                context,
                'Title $index is a very long title that might overflow and needs to be truncated',
                'Content $index',
                '${index + 1}',
                '${DateTime.now().subtract(Duration(days: index)).toString().split(' ')[0]}',
              );
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: const Color.fromARGB(255, 237, 229, 229),
                    width: 1.0,
                  ),
                ),
              ),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(children: [
                    Icon(Icons.article, color: Colors.blue[900]),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                  ]),
                ),
              ),
            ),
          ),
      ],
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
}
