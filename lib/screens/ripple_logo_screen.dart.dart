import 'package:flutter/material.dart';
import 'package:medcross/screens/sign_in_page.dart';

class RippleLogoScreen extends StatefulWidget {
  const RippleLogoScreen({super.key});

  @override
  State<RippleLogoScreen> createState() => _RippleLogoScreenState();
}

class _RippleLogoScreenState extends State<RippleLogoScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rippleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward(); // Start animation only once

    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Navigate to SignInPage after animation completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignInPage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF021e45), // Background color
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // First ripple effect (darkest shade of white)
            AnimatedBuilder(
              animation: _rippleAnimation,
              builder: (context, child) {
                return Container(
                  width: 150 * _rippleAnimation.value + 170,
                  height: 150 * _rippleAnimation.value + 170,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                        .withOpacity(0.7 * (1 - _rippleAnimation.value)),
                  ),
                );
              },
            ),
            // Second ripple effect (lighter shade of white)
            AnimatedBuilder(
              animation: _rippleAnimation,
              builder: (context, child) {
                return Container(
                  width: 200 * _rippleAnimation.value + 170,
                  height: 200 * _rippleAnimation.value + 170,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                        .withOpacity(0.5 * (1 - _rippleAnimation.value)),
                  ),
                );
              },
            ),
            // Third ripple effect (even lighter shade of white)
            AnimatedBuilder(
              animation: _rippleAnimation,
              builder: (context, child) {
                return Container(
                  width: 250 * _rippleAnimation.value + 170,
                  height: 250 * _rippleAnimation.value + 170,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                        .withOpacity(0.3 * (1 - _rippleAnimation.value)),
                  ),
                );
              },
            ),
            // Fourth ripple effect (lightest shade of white)
            AnimatedBuilder(
              animation: _rippleAnimation,
              builder: (context, child) {
                return Container(
                  width: 300 * _rippleAnimation.value + 170,
                  height: 300 * _rippleAnimation.value + 170,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                        .withOpacity(0.1 * (1 - _rippleAnimation.value)),
                  ),
                );
              },
            ),
            // Circular logo with padding to prevent overlapping with edges
            ClipOval(
              child: Container(
                width: 160, // Size of the circle
                height: 160, // Size of the circle
                color: Colors.white, // Background color of the circle
                padding: const EdgeInsets.all(
                    10), // Added padding to prevent overlap
                child: Image.asset(
                  'assets/tbclinic.jpg',
                  fit: BoxFit
                      .contain, // Ensure the entire logo fits within the circle
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
