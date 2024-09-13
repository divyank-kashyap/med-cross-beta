import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON decoding
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Define a model for patient data
class Patient {
  final String name;
  final int age;
  final String gender;
  final String status;
  final String referredNo;

  Patient(
      {required this.name,
      required this.age,
      required this.gender,
      required this.status,
      required this.referredNo});

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      name: json['patientName'] ?? 'Unknown',
      age: json['patientAge'] ?? 0,
      gender: json['patientGender'] ?? 'Unknown',
      status: json['status'] ?? 'No Status',
      referredNo: json['referredNo'] ?? 'N/A',
    );
  }
}

void main() => runApp(PatientListApp());

class PatientListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patient List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PatientListPage(),
    );
  }
}

class PatientListPage extends StatefulWidget {
  @override
  _PatientListPageState createState() => _PatientListPageState();
}

class _PatientListPageState extends State<PatientListPage> {
  List<Patient> patients = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchPatients();
  }

  // Fetch patients from API
  Future<void> fetchPatients() async {
    final url = Uri.parse(
        'http://20.219.27.255/staging/practice_core_api/api/ReferredPatients/getreferredpatients');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Log the API response
        print('API Response: ${response.body}');

        // Parse the JSON response
        List<dynamic> data = json.decode(response.body)[
            'patients']; // Adjust the key based on API response structure
        setState(() {
          patients =
              data.map((patientJson) => Patient.fromJson(patientJson)).toList();
          isLoading = false;
          hasError = false;
        });
      } else {
        print('Failed to load patients. Status code: ${response.statusCode}');
        setState(() {
          isLoading = false;
          hasError = true;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient List', style: TextStyle(color: Color(0xFF2F2E41))),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/profile_image.png'),
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child:
                  CircularProgressIndicator()) // Show loading spinner while fetching data
          : hasError
              ? Center(child: Text('Failed to load patients.'))
              : patients.isEmpty
                  ? Center(
                      child: Text(
                          'No patients found.')) // Show this if no patients are returned
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: patients.length,
                        itemBuilder: (context, index) {
                          return PatientCard(
                              patient:
                                  patients[index]); // Pass patient data to card
                        },
                      ),
                    ),
      bottomNavigationBar: BottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action for the floating button (refer a patient)
        },
        child: Icon(FontAwesomeIcons.handsHelping, color: Colors.white),
        backgroundColor: Color(0xFFE63946),
      ),
    );
  }
}

// Patient card widget that accepts patient data
class PatientCard extends StatelessWidget {
  final Patient patient;

  const PatientCard({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF3A2F84),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/patient_image.png'), // Placeholder image for now
              radius: 30,
            ),
            SizedBox(height: 10),
            Text(
              patient.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5),
            Text(
              '${patient.age} years | ${patient.gender}',
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 5),
            Text(
              'Status: ${patient.status}',
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFFE63946),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Referred No: ${patient.referredNo}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home, color: Color(0xFFB7B7C8)),
            onPressed: () {
              // Navigate to home
            },
          ),
          IconButton(
            icon:
                FaIcon(FontAwesomeIcons.stethoscope, color: Color(0xFFE63946)),
            onPressed: () {
              // Navigate to refer a patient
            },
          ),
          SizedBox(width: 40),
          IconButton(
            icon: Icon(Icons.location_on, color: Color(0xFFB7B7C8)),
            onPressed: () {
              // Navigate to location page
            },
          ),
          IconButton(
            icon: Icon(Icons.phone, color: Color(0xFFB7B7C8)),
            onPressed: () {
              // Navigate to contact page
            },
          ),
        ],
      ),
    );
  }
}
