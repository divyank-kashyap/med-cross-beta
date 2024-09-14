import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON decoding
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Define a model for contact details
class ContactDetail {
  final int rowId;
  final int mobileNo;
  final String address;

  ContactDetail({
    required this.rowId,
    required this.mobileNo,
    required this.address,
  });

  factory ContactDetail.fromJson(Map<String, dynamic> json) {
    return ContactDetail(
      rowId: json['row_ID'],
      mobileNo: json['mobile_No'],
      address: json['address'],
    );
  }
}

// Define a model for patient data
class Patient {
  final int rowId;
  final String firstName;
  final String lastName;
  final String gender;
  final int patientStatus;
  final int age;
  final ContactDetail contactDetail;

  Patient({
    required this.rowId,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.patientStatus,
    required this.age,
    required this.contactDetail,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      rowId: json['row_Id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      patientStatus: json['patient_Status'],
      age: json['age'],
      contactDetail: ContactDetail.fromJson(json['contactDetail']),
    );
  }
}

class PatientListPage extends StatefulWidget {
  final String authToken; // Token passed from previous page

  const PatientListPage({Key? key, required this.authToken}) : super(key: key);

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
      'http://20.219.27.255/staging/practice_core_api/api/ReferredPatients/getreferredpatients',
    );
    try {
      final headers = {
        'Authorization': 'Bearer ${widget.authToken}', // Use dynamic token
        'Content-Type': 'application/json',
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        print('API Response: ${response.body}');
        List<dynamic> data = json.decode(response.body);
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
              backgroundImage: AssetImage('assets/profile_image.jpg'),
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            ) // Show loading spinner while fetching data
          : hasError
              ? Center(child: Text('Failed to load patients.'))
              : patients.isEmpty
                  ? Center(
                      child: Text('No patients found.'),
                    ) // Show this if no patients are returned
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio:
                              0.75, // Adjusted to match the design
                        ),
                        itemCount: patients.length,
                        itemBuilder: (context, index) {
                          return PatientCard(
                              patient:
                                  patients[index]); // Pass patient data to card
                        },
                      ),
                    ),
      bottomNavigationBar: buildBottomAppBar(context),
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

  Widget buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home, color: Colors.grey),
            onPressed: () {
              // Navigate to Home
            },
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.stethoscope, color: Color(0xFFE63946)),
            onPressed: () {
              // Navigate to another page (Refer patient)
            },
          ),
          SizedBox(width: 40), // Space for floating action button
          IconButton(
            icon: Icon(FontAwesomeIcons.mapMarkerAlt, color: Colors.grey),
            onPressed: () {
              // Navigate to Centre Map page
            },
          ),
          IconButton(
            icon: Icon(Icons.phone, color: Colors.grey),
            onPressed: () {
              // Navigate to Contact page
            },
          ),
        ],
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
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/patient_image.png'), // Placeholder image for now
              radius: 30,
            ),
            SizedBox(height: 10),
            Text(
              '${patient.firstName} ${patient.lastName}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              '${patient.age} years | ${patient.gender == 'm' ? 'Male' : 'Female'}',
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              'Status: ${patient.patientStatus == 1 ? "Treatment Started" : "Other Status"}',
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFFE63946),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Referred No: #${patient.rowId}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
