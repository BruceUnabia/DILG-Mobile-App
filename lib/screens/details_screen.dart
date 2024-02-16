import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String title;
  final String content;
  final String referenceNo;
  final String date;

  const DetailsScreen({
    required this.title,
    required this.content,
    required this.referenceNo,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 2),
                Divider(
                  color: Colors.grey,
                  thickness: 2,
                  height: 2,
                ),
                Center(
                  child: Text(
                    content,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ref # $referenceNo',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Date: $date',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Add your PDF download logic here
                      // Example: downloadPdfFunction();
                      // Make sure to implement the logic for downloading PDF
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Background color
                      disabledBackgroundColor: Colors.white, // Text color
                      padding: EdgeInsets.symmetric(
                          horizontal: 20), // Horizontal padding
                    ),
                    child: Text("Download PDF"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
