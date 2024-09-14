import 'package:flutter/material.dart';
import 'dart:convert'; // For encoding and decoding JSON
import 'package:http/http.dart' as http;
import 'patientFile.dart'; // Import the PatientListPage for navigation after login
import 'signUpPage.dart'; // Ensure correct import of SignUpPage

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  late AnimationController _rippleController;
  late Animation<double> _rippleAnimation;
  late AnimationController _inputBlockController;
  late Animation<double> _inputBlockAnimation;
  double _bottomOffset = 50.0; // Initial bottom offset

  // Controllers to capture the input values
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Ripple animation setup
    _rippleController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward(); // Play animation once

    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );

    // Input block animation setup
    _inputBlockController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward(); // Start the animation immediately

    _inputBlockAnimation = Tween<double>(begin: 0.5, end: 0.8).animate(
      CurvedAnimation(parent: _inputBlockController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _rippleController.dispose();
    _inputBlockController.dispose();
    _mobileController.dispose(); // Clean up controllers
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    final String mobile = _mobileController.text;
    final String password = _passwordController.text;

    final url = Uri.parse(
        "http://20.219.27.255/staging/practice_core_api/api/account/rdlogin");

    try {
      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "Mobile": mobile,
          "Password": password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (responseBody.containsKey('token')) {
          final String token = responseBody['token'];

          // Navigate to PatientDetailsPage with the token
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PatientListPage(authToken: token),
            ),
          );
        } else {
          print("Invalid response: ${response.body}");
          _showErrorDialog("Login failed. Invalid response from server.");
        }
      } else {
        print("Failed to log in: ${response.statusCode}");
        print("Response body: ${response.body}");
        _showErrorDialog("Login failed. Please check your credentials.");
      }
    } catch (error) {
      print("Error occurred: $error");
      _showErrorDialog("An error occurred. Please try again.");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Listen to keyboard visibility
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final keyboardVisibility = MediaQuery.of(context).viewInsets.bottom;
      setState(() {
        _bottomOffset = keyboardVisibility > 0
            ? 20.0
            : 50.0; // Adjust based on keyboard visibility
      });
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Ripple animation and logo at the top center
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0), // Adjust as needed
              child: AnimatedBuilder(
                animation: _rippleAnimation,
                builder: (context, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 180 + 200 * _rippleAnimation.value,
                        height: 180 + 200 * _rippleAnimation.value,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white
                              .withOpacity(0.1 * (1 - _rippleAnimation.value)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(25),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/tbclinic.jpg',
                            width: 90,
                            height: 110,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          // Input fields and other content
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            bottom: _bottomOffset, // Adjust based on keyboard visibility
            left: 20,
            right: 20,
            child: AnimatedBuilder(
              animation: _inputBlockAnimation,
              builder: (context, child) {
                return SingleChildScrollView(
                  child: Transform.translate(
                    offset: Offset(
                      0,
                      MediaQuery.of(context).size.height *
                          (0.8 - _inputBlockAnimation.value),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF021e45),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.center, // Center align children
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            'Welcome Back!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Sign in to your account',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF6c757d),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _mobileController, // Link controller
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter Mobile Number',
                              hintStyle: const TextStyle(color: Colors.black54),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _passwordController, // Link controller
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Password',
                              hintStyle: const TextStyle(color: Colors.black54),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              _signIn(); // Call the sign-in method
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 50,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account?',
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(width: 5),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpPage()),
                                  );
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
