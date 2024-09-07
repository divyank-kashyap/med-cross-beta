import 'package:flutter/material.dart';
import 'package:medcross/screens/signUpPage.dart'; // Import SignUpPage

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
    super.dispose();
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
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Enter Username/Email Address',
                              labelStyle: const TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Password',
                              labelStyle: const TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              // Handle sign-in logic here
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
                                    builder: (context) => const SignUpPage()),
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
