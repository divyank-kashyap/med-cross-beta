import 'package:flutter/material.dart';

class CentreMapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn.pixabay.com/photo/2024/02/28/07/42/european-shorthair-8601492_640.jpg'), // Add profile image URL here
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Our Centers",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2024/02/28/07/42/european-shorthair-8601492_640.jpg'), // Add map image URL here
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.white70,
                    child: Text(
                      "MEDCROSS CLINIC C-45, west jyoti nagar shahdra, delhi -110094",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                          0xFFBB271C), // Corrected: Use backgroundColor
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      "Direction",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor:
                          Colors.black87, // Corrected: Use foregroundColor
                      side: BorderSide(color: Colors.black87),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text("Contact"),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Our Doctors",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF021e45),
                ),
              ),
              SizedBox(height: 30),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: 5, // Adjust according to the number of doctors
                itemBuilder: (context, index) {
                  return DoctorCard(
                    name: "Don Aditya ", // Replace with dynamic data
                    experience: "2 yr Exp.| Reyna Main",
                    phone: "+91 6969696969",
                    registrationNumber: "#012341",
                    imageUrl:
                        'https://pbs.twimg.com/media/FIXCymMWUAsdDJc.jpg', // Add doctor image URL here
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Doctors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Centers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_phone),
            label: 'Contact',
          ),
        ],
        currentIndex: 2, // Set the selected index as per the page
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String name;
  final String experience;
  final String phone;
  final String registrationNumber;
  final String imageUrl;

  const DoctorCard({
    required this.name,
    required this.experience,
    required this.phone,
    required this.registrationNumber,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior:
          Clip.none, // Allows the image to be positioned outside the container
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xFF353365), // Use the specified hex color
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30), // Add some spacing for the image
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              Text(
                experience,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              Text(
                phone,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Spacer(),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                color: const Color(0xFFBB271C),
                child: Text(
                  'Registration No: $registrationNumber',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -10, // Adjust this value to move the image up or down
          left: 0,
          right: 0,
          child: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(imageUrl),
            backgroundColor:
                Colors.white, // Optional: Add a white background for the image
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CentreMapPage(),
  ));
}
