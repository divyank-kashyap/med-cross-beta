import 'package:flutter/material.dart';
import 'package:medcross/screens/refer_patient.dart';
import 'sign_in_page.dart';

// Import your additional pages
import 'CentreMapPage.dart';
import 'ask_for_help_page.dart';
import 'profile_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TB Clinic',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
      routes: {
        '/MyProfile': (context) => ProfileApp(),
        '/referAPatient': (context) => ReferPatient(),
        '/patientList': (context) => PatientListPage(),
        '/HomePage': (context) => HomePage(),
        '/CentreMapPage': (context) => CentreMapPage(),
        '/askForHelpPage': (context) => AskForHelpPage(),
        '/profilePage': (context) => ProfileApp(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TB Clinic'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: CircleAvatar(
              backgroundImage:
                  AssetImage('assets/profile_image.png'), // Ensure asset exists
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/MyProfile');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildInfoCard(),
            SizedBox(height: 20),
            buildStatCard(context),
            SizedBox(height: 20),
            buildPatientStoriesSection(),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/referAPatient');
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }

  Widget buildInfoCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Treated Highest No. Of TB Patients In Delhi As An Individual Doctor',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(width: 10),
          Image.asset(
            'assets/doctor.png', // Ensure asset exists
            height: 80,
          ),
        ],
      ),
    );
  }

  Widget buildStatCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '8000+',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            'Patients Treated Overall With 97.7% Rate',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/referAPatient');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Contribute Now'),
          ),
        ],
      ),
    );
  }

  Widget buildPatientStoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PATIENT STORIES',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10),
        buildStoryCard(),
      ],
    );
  }

  Widget buildStoryCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/patient_image.png'), // Ensure asset exists
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Salman Nasrudin',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '18 Years',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                Icons.star,
                color: index < 4 ? Colors.red : Colors.grey,
                size: 20,
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget buildBottomNavigationBar(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamed(context, '/HomePage');
            },
          ),
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {
              Navigator.pushNamed(context, '/CentreMapPage');
            },
          ),
          SizedBox(width: 40), // Space for floating action button
          IconButton(
            icon: Icon(Icons.phone),
            onPressed: () {
              Navigator.pushNamed(context, '/askForHelpPage');
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profilePage');
            },
          ),
        ],
      ),
    );
  }
}

// Placeholder pages for navigation routes
class MyProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Profile")),
      body: Center(child: Text("My Profile Page")),
    );
  }
}

class ReferAPatientPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Refer a Patient")),
      body: Center(child: Text("Refer a Patient Page")),
    );
  }
}

class LocateUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Locate Us")),
      body: Center(child: Text("Locate Us Page")),
    );
  }
}

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact Us")),
      body: Center(child: Text("Contact Us Page")),
    );
  }
}

class PatientListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Patient List")),
      body: Center(child: Text("Patient List Page")),
    );
  }
}

class CentreMapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Centre Map")),
      body: Center(child: Text("Centre Map Page")),
    );
  }
}

class AskForHelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ask for Help")),
      body: Center(child: Text("Ask for Help Page")),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile Page")),
      body: Center(child: Text("Profile Page")),
    );
  }
}
