import 'package:flutter/material.dart';
import 'dart:convert'; // For encoding and decoding JSON
import 'package:http/http.dart' as http;
import 'signUpPage.dart'; // Ensure correct import of SignUpPage

// Import HomePage or create a placeholder
import 'homePage.dart'; // Ensure this path is correct and points to HomePage

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

        // Assume the token is returned with key 'token'
        final String token = responseBody['token'];

        // Retrieve user details using the token
        final userDetails = await _getUserDetails(token);

        // Navigate to the HomePage after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(), // HomePage route
          ),
        );
      } else {
        print("Failed to log in: ${response.statusCode}");
        _showErrorDialog("Login failed. Please check your credentials.");
      }
    } catch (error) {
      print("Error occurred: $error");
      _showErrorDialog("An error occurred. Please try again.");
    }
  }

  Future<Map<String, dynamic>?> _getUserDetails(String token) async {
    final url = Uri.parse(
        "http://20.219.27.255/staging/practice_core_api/api/account/userDetails");

    try {
      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> userDetails = jsonDecode(response.body);
        print("User Details: $userDetails");
        return userDetails;
      } else {
        print("Failed to retrieve user details: ${response.statusCode}");
        return null;
      }
    } catch (error) {
      print("Error occurred: $error");
      return null;
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
                        width: 180 + 150 * _rippleAnimation.value,
                        height: 180 + 150 * _rippleAnimation.value,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red
                              .withOpacity(0.2 * (1 - _rippleAnimation.value)),
                        ),
                      ),
                      Container(
                        width: 180 + 100 * _rippleAnimation.value,
                        height: 180 + 100 * _rippleAnimation.value,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue
                              .withOpacity(0.3 * (1 - _rippleAnimation.value)),
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
                              hintText:
                                  'Enter Mobile Number', // Use hintText instead of labelText
                              hintStyle: const TextStyle(
                                  color:
                                      Colors.black54), // Placeholder text style
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors
                                      .blue, // Change this to your preferred color for focus
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
                              hintText:
                                  'Password', // Use hintText instead of labelText
                              hintStyle: const TextStyle(color: Colors.black54),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors
                                      .blue, // Change this to your preferred color for focus
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
                              backgroundColor: const Color(0xFFd32f2f),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50.0, vertical: 15.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text(
                              'Sign In',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextButton(
                            onPressed: () {
                              // Navigate to SignUpPage
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpPage()), // Updated here
                              );
                            },
                            child: const Text(
                              "Don't have an account? Sign Up",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
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
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SignInPage(),
  ));
}
