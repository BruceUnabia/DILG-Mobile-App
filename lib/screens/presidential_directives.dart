import 'package:flutter/material.dart';
import 'sidebar.dart';
import 'details_screen.dart';

class PresidentialDirectives extends StatefulWidget {
  @override
  _PresidentialDirectivesState createState() => _PresidentialDirectivesState();
}

class _PresidentialDirectivesState extends State<PresidentialDirectives> {
  List<String> categories = [
    '1: Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    '2: Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    '3: Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ];
  String selectedCategory =
      '1: Lorem ipsum dolor sit amet, consectetur adipiscing elit.'; // Default selection

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
      body: _buildBody(),
      drawer: Sidebar(
        currentIndex: 4, // Adjust the index based on your sidebar menu
        onItemSelected: (index) {
          // Handle item selection if needed
          Navigator.pop(context); // Close the drawer after handling selection
        },
      ),
    );
  }

  Widget _buildBody() {
    TextEditingController searchController = TextEditingController();

    return SingleChildScrollView(
      child: Column(
        children: [
          // Search Input
          Container(
            margin: EdgeInsets.only(bottom: 8.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                // Handle search input changes
              },
            ),
          ),

          // Category Dropdown
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title/Subject: ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[400]!),
                  ),
                  padding: EdgeInsets.all(12.0),
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
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  value,
                                  overflow: TextOverflow.ellipsis,
                                )),
                          ));
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

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
                SizedBox(height: 16.0),
                for (int index = 0; index < 11; index++)
                  InkWell(
                    onTap: () {
                      _navigateToDetailsPage(
                        context,
                        'Card title $index is a very long title that might overflow and needs to be truncated',
                        'Content $index',
                        '${index + 1}',
                        '${DateTime.now().subtract(Duration(days: index)).toString().split(' ')[0]}',
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Icon(Icons.article,
                                color: Colors.blue[
                                    900]), // Replace with your desired icon
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
                                ])),
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
}
