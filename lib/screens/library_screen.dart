import 'package:flutter/material.dart';
import 'details_screen.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

class LibraryScreen extends StatefulWidget {
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  TextEditingController _searchController = TextEditingController();
  List<String> _latestIssuances =
      List.generate(5, (index) => 'Latest Issuance $index');
  List<String> _jointCirculars =
      List.generate(6, (index) => 'Joint Circular $index');
  List<String> _memoCirculars =
      List.generate(6, (index) => 'Memo Circular $index');
  List<String> _presidentialDirectives =
      List.generate(6, (index) => 'Presidential Directive $index');
  List<String> _draftIssuances =
      List.generate(6, (index) => 'Draft Issuance $index');
  List<String> _republicActs =
      List.generate(6, (index) => 'Republic Act $index');
  List<String> _legalOpinions =
      List.generate(6, (index) => 'Legal Opinion $index');

  String _selectedCategory = 'All';
  List<String> _categories = [
    'All',
    'Latest Issuances',
    'Joint Circulars',
    'Memo Circulars',
    'Presidential Directives',
    'Draft Issuances',
    'Republic Acts',
    'Legal Opinions',
  ];

  // int _currentIndex = 1;
  // List<String> _drawerMenuItems = [
  //   'Home',
  //   'Search',
  //   'Library',
  //   'View Profile',
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnimSearchBar(
                width: 400,
                onSubmitted: (query) {
                  // Handle the submitted search query
                  print('Search submitted: $query');
                },
                onSuffixTap: () {
                  setState(() {
                    _searchController.clear();
                  });
                },
                color: Colors.blue[200]!,
                helpText: "Search...",
                autoFocus: true,
                closeSearchOnSuffixTap: true,
                animationDurationInMilli: 750,
                rtl: true,
                textController: _searchController,
              ),
              _buildSearchAndFilterRow(),
              // Use a common method to build each section
              _buildSection('Latest Issuances', _latestIssuances),
              _buildSection('Joint Circulars', _jointCirculars),
              _buildSection('Memo Circulars', _memoCirculars),
              _buildSection('Presidential Directives', _presidentialDirectives),
              _buildSection('Draft Issuances', _draftIssuances),
              _buildSection('Republic Acts', _republicActs),
              _buildSection('Legal Opinions', _legalOpinions),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: 80, // Set the desired height here
      //   child: BottomNavigationBar(
      //     currentIndex: _currentIndex,
      //     onTap: (int index) {
      //       setState(() {
      //         _currentIndex = index.clamp(0, _drawerMenuItems.length - 1);
      //       });
      //     },
      //     items: const [
      //       BottomNavigationBarItem(
      //         backgroundColor: Color.fromARGB(255, 3, 80, 162),
      //         icon: Icon(
      //           Icons.home,
      //           size: 25,
      //           color: Colors.white,
      //         ),
      //         label: 'Home',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.search,
      //           size: 25,
      //           color: Colors.white,
      //         ),
      //         label: 'Search',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.library_books,
      //           size: 25,
      //           color: Colors.white,
      //         ),
      //         label: 'Library',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.people,
      //           size: 25,
      //           color: Colors.white,
      //         ),
      //         label: 'Profile',
      //       ),
      //     ],
      //     selectedItemColor: Colors.white,
      //     unselectedItemColor: Colors.white.withOpacity(0.5),
      //   ),
      // ),
    );
  }

  // Method to build the search input and category filter row
  Widget _buildSearchAndFilterRow() {
    return Row(
      children: [
        // DropdownButton<String>(
        //   value: _selectedCategory,
        //   onChanged: (String? newValue) {
        //     setState(() {
        //       _selectedCategory = newValue!;
        //     });
        //   },
        //   items: _categories.map((String category) {
        //     return DropdownMenuItem<String>(
        //       value: category,
        //       child: Text(
        //         category,
        //         style: TextStyle(color: Colors.black),
        //       ),
        //     );
        //   }).toList(),
        //   style: TextStyle(color: Colors.black),
        //   icon: Icon(Icons.arrow_drop_down),
        //   iconSize: 24,
        //   elevation: 16,
        //   underline: Container(
        //     height: 2,
        //     color: Colors.blue[900],
        //   ),
        // ),
        // SizedBox(width: 16),

        // Expanded(
        //   child: Container(
        //     padding: EdgeInsets.symmetric(horizontal: 16),
        //     decoration: BoxDecoration(
        //       color: Colors.grey[200],
        //       borderRadius: BorderRadius.circular(10),
        //     ),
        //     child: TextField(
        //       controller: _searchController,
        //       onChanged: (value) {
        //         setState(() {
        //           // Handle search query changes here
        //         });
        //       },
        //       decoration: InputDecoration(
        //         hintText: 'Search',
        //         border: InputBorder.none,
        //         icon: Icon(Icons.search),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  // Updated _buildSection method to filter items based on selected category and search query
  Widget _buildSection(String title, List<String> items) {
    // Filter items based on selected category and search query
    List<String> filteredItems = items
        .where((item) =>
            (_selectedCategory == 'All' || title == _selectedCategory) &&
            (item.toLowerCase().contains(_searchController.text.toLowerCase())))
        .toList();

    if (filteredItems.isEmpty) {
      return Container(); // Return an empty container if no items match the criteria
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 16),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                            title: 'Card Title $index',
                            content:
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                            referenceNo: '',
                            date: ''),
                      ),
                    );
                  },
                  child: Container(
                    width: 300,
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Card Title $index',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Expanded(
                          child: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 7,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
