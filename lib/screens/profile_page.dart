import 'package:flutter/material.dart';

void main() {
  runApp(ProfileApp());
}

class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Page',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Color(0xFF353365), // Main color of the app
          onPrimary: Colors.white, // Color for text/icons on primary color
        ),
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor:
            Theme.of(context).colorScheme.primary, // Primary color for AppBar
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Theme.of(context)
                  .colorScheme
                  .onPrimary), // Ensures the icon is white
          onPressed: () {
            // Handle back button action
          },
        ),
      ),
      body: Stack(
        children: [
          // Blue oval background
          ClipPath(
            clipper: OvalClipper(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primary, // Using primary color
              ),
            ),
          ),
          // Content
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.12),
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor:
                      Theme.of(context).colorScheme.onPrimary, // White border
                  child: CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage(
                        'assets/profile.jpg'), // Replace with your image path
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Coal Minor',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '+91 1234567890',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20),
              // Details section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListView(
                    children: [
                      _buildDetailItem('Phone No.', '+911234567980'),
                      _buildDetailItem('Address',
                          'Level 3/551 Swanston St, Carlton VIC 3053, Australia'),
                      _buildDetailItem('Code No.', '302012'),
                      _buildDetailItem('Area', 'Vdn'),
                      _buildDetailItem('Payment Phone No.', '+911234567980'),
                      _buildDetailItem('Clinic Name', 'TB Clonic'),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Handle logout action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, // Logout button color
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text('Logout'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String title, String detail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(height: 5),
        Text(
          detail,
          style: TextStyle(fontSize: 16),
        ),
        Divider(),
      ],
    );
  }
}

class OvalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.6);
    path.quadraticBezierTo(
        size.width * 0.5, size.height, size.width, size.height * 0.6);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
