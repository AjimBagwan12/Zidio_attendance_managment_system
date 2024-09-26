import 'package:attendance_management_system/auth/signup_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Screen/AttendanceHistory_Screen.dart';
import 'Screen/AttendanceMarking_Screen.dart';
import 'Screen/Dashborad_Screen.dart';
import 'Screen/ProfileUpdate_Screen.dart';
import 'Screen/Reporting_Screen.dart';
import 'auth/PhoneLoginScreen.dart';
import 'auth/login_Screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable debug banner
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/phoneLogin': (context) => PhoneLoginScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/attendance': (context) => AttendanceMarkingScreen(),
        '/attendance_history': (context) => AttendanceHistoryScreen(),
        '/reports': (context) => ReportingScreen(),
        '/profile': (context) => ProfileUpdateScreen(),
        // Add more routes as needed for other features/screens
      },
    );
  }
}
