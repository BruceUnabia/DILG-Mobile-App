import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'sidebar.dart';
import 'details_screen.dart';
import 'package:http/http.dart' as http;

class LegalOpinions extends StatefulWidget {
  @override
  _LegalOpinionsState createState() => _LegalOpinionsState();
}

class _LegalOpinionsState extends State<LegalOpinions> {
  List<LegalOpinion> _legalOpinions = [];
  List<LegalOpinion> get legalOpinions => _legalOpinions;

  List<String> categories = [
    '1: Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    '2: Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    '3: Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ];
  String selectedCategory =
      '1: Lorem ipsum dolor sit amet, consectetur adipiscing elit.'; // Default selection

  @override
  void initState() {
    super.initState();
    fetchLegalOpinions();
  }

  Future<void> fetchLegalOpinions() async {
    final response = await http.get(
        Uri.parse('https://dilg.mdc-devs.com/api/legal_opinions'),
        headers: {
          'Accept': 'application/json',
        });

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['legals'];

      setState(() {
        _legalOpinions =
            data.map((item) => LegalOpinion.fromJson(item)).toList();
      });
    } else {
      print('Failed to load latest legal opinions');
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Legal Opinions',
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
        currentIndex: 7, // Adjust the index based on your sidebar menu
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
                for (int index = 0; index < _legalOpinions.length; index++)
                  InkWell(
                    onTap: () {
                      _navigateToDetailsPage(context, _legalOpinions[index]);
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _legalOpinions[index].issuance.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    'Ref #${_legalOpinions[index].issuance.referenceNo}',
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
                              DateFormat('MMMM dd, yyyy').format(
                                DateTime.parse(
                                    _legalOpinions[index].issuance.date),
                              ),
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

  void _navigateToDetailsPage(BuildContext context, LegalOpinion issuance) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsScreen(
            title: issuance.issuance.title,
            content: '',
            referenceNo: '${issuance.issuance.referenceNo}',
            date:
                '${DateFormat('MMMM dd, yyyy').format(DateTime.parse(issuance.issuance.date))}'),
      ),
    );
  }

  void _navigateToSelectedPage(BuildContext context, int index) {}
}

class LegalOpinion {
  final int id;
  final String category;
  final Issuance issuance;

  LegalOpinion({
    required this.id,
    required this.category,
    required this.issuance,
  });

  factory LegalOpinion.fromJson(Map<String, dynamic> json) {
    return LegalOpinion(
      id: json['id'],
      category: json['category'],
      issuance: Issuance.fromJson(json['issuance']),
    );
  }
}

class Issuance {
  final int id;
  final String date;
  final String title;
  final String referenceNo;
  final String keyword;
  final String urlLink;

  Issuance({
    required this.id,
    required this.date,
    required this.title,
    required this.referenceNo,
    required this.keyword,
    required this.urlLink,
  });

  factory Issuance.fromJson(Map<String, dynamic> json) {
    return Issuance(
      id: json['id'],
      date: json['date'],
      title: json['title'],
      referenceNo: json['reference_no'],
      keyword: json['keyword'],
      urlLink: json['url_link'],
    );
  }
}
