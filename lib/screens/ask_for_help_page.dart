import 'package:flutter/material.dart';

class AskForHelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF353365), // Dark blue color
        title: Text('Ask For Help'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://i.imgur.com/BoN9kdC.png'), // Replace with actual profile image URL
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              // Blue background behind the query area
              Container(
                height: 180.0, // Height to cover part of the query area
                color: Color(0xFF353365), // Dark blue color
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 40.0), // Moves the TextField down
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white, // White background for the TextField
                  ),
                  child: TextField(
                    maxLines: 6, // Increase the height of the query area
                    decoration: InputDecoration(
                      hintText: 'Your Query',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          EdgeInsets.all(16.0), // Padding inside the text area
                    ),
                  ),
                ),
              ),
            ],
          ),

          // White section with Submit button
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: ElevatedButton(
              onPressed: () {
                // Add your submit functionality here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFFBB271C), // Red color for the submit button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Submit', style: TextStyle(fontSize: 18)),
              ),
            ),
          ),

          // Newly added blue section before the bottom navigation bar
          Container(
            height: 200.0, // Adjust the height as per your requirement
            color: Color(0xFF353365), // Dark blue section at the bottom
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home, color: Colors.blueGrey),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.child_care, color: Colors.blueGrey),
                onPressed: () {},
              ),
              FloatingActionButton(
                onPressed: () {},
                backgroundColor: Color(0xFFE74C3C), // Red color
                child: Icon(Icons.mic),
              ),
              IconButton(
                icon: Icon(Icons.location_on, color: Colors.blueGrey),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.phone, color: Colors.blueGrey),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AskForHelpPage(),
  ));
}
