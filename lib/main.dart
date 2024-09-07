import 'package:flutter/material.dart';
import 'screens/CentreMapPage.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Ripple Animation App',
//       home: const RippleLogoScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

void main() {
  runApp(MaterialApp(
    initialRoute: '/refer_patient', // Replace with the route name of your page
    routes: {
      '/': (context) => CentreMapPage(),
      '/centre-map': (context) => CentreMapPage(), // Ensure this route exists
    },
  ));
}
