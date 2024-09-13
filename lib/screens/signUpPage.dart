import 'package:flutter/material.dart';
import 'sign_in_page.dart'; // Import SignInPage

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rippleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward(); // Play animation once

    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 2.0, horizontal: 2.0), // Reduced top padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Ripple animations behind the logo
                    AnimatedBuilder(
                      animation: _rippleAnimation,
                      builder: (context, child) {
                        return Container(
                          width: 50 + 50 * _rippleAnimation.value,
                          height: 120 + 120 * _rippleAnimation.value,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(
                                0.1 * (1 - _rippleAnimation.value)),
                          ),
                        );
                      },
                    ),
                    AnimatedBuilder(
                      animation: _rippleAnimation,
                      builder: (context, child) {
                        return Container(
                          width: 50 + 50 * _rippleAnimation.value,
                          height: 120 + 120 * _rippleAnimation.value,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red.withOpacity(
                                0.2 * (1 - _rippleAnimation.value)),
                          ),
                        );
                      },
                    ),
                    AnimatedBuilder(
                      animation: _rippleAnimation,
                      builder: (context, child) {
                        return Container(
                          width: 120 + 120 * _rippleAnimation.value,
                          height: 120 + 120 * _rippleAnimation.value,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue.withOpacity(
                                0.3 * (1 - _rippleAnimation.value)),
                          ),
                        );
                      },
                    ),
                    // Logo with padding and size
                    Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
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
                ),
                const SizedBox(height: 20), // Reduced gap between logo and form
                // Blue background only behind form (rounded corner container)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  margin: const EdgeInsets.only(bottom: 20.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF021e45), // Blue background
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Access to your account',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF6c757d),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        hintText: 'Name',
                        icon: Icons.person,
                      ),
                      _buildTextField(
                        hintText: 'E-mail',
                        icon: Icons.email,
                      ),
                      _buildTextField(
                        hintText: 'Phone No.',
                        icon: Icons.phone,
                      ),
                      _buildTextField(
                        hintText: 'Area',
                        icon: Icons.location_on,
                      ),
                      _buildTextField(
                        hintText: "Doctor's Code",
                        icon: Icons.medical_services,
                      ),
                      _buildTextField(
                        hintText: 'Phone No.',
                        icon: Icons.phone,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Handle sign-up logic here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFd32f2f), // Red button color
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          // Navigate to SignInPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInPage()),
                          );
                        },
                        child: const Text(
                          'Already have an account? Sign In',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white, // White text
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method to build text fields with icons
  Widget _buildTextField({required String hintText, required IconData icon}) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText, // Use hintText instead of labelText
        hintStyle:
            const TextStyle(color: Colors.grey), // Customize hint text style
        suffixIcon: Icon(icon, color: Colors.grey), // Icon moved to the right
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 15.0), // Increased padding for larger input area
      ),
    );
  }
}
