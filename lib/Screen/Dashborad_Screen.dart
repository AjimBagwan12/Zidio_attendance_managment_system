import 'package:flutter/material.dart';
import 'AttendanceHistory_Screen.dart';
import 'AttendanceMarking_Screen.dart'; // Import your AttendanceMarkingScreen

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late String _userEmail;

  @override
  void initState() {
    super.initState();
    _fetchUserEmail(); // Fetch user email when the widget initializes
  }

  Future<void> _fetchUserEmail() async {
    // Simulating fetching user email from Firebase
    await Future.delayed(Duration(seconds: 1)); // Replace with actual Firebase logic
    setState(() {
      _userEmail = 'example@email.com'; // Replace with actual user email
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.blueGrey[500], // Darker shade of blue-grey
        automaticallyImplyLeading: false, // Hide back button
      ),
      body: Container(
        color: Colors.grey[200], // Light grey background color
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Welcome!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.email, color: Colors.blueGrey[600]), // Adjust icon color
              title: Text(
                'Email',
                style: TextStyle(fontSize: 16, color: Colors.blueGrey[600]), // Adjust text color
              ),
              subtitle: Text(
                _userEmail ?? '', // Ensure _userEmail is not null
                style: TextStyle(fontSize: 14, color: Colors.blueGrey), // Adjust text color
              ),
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                // Navigate to AttendanceHistoryScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendanceHistoryScreen(),
                  ),
                );
              },
              child: ListTile(
                leading: Icon(Icons.assignment, color: Colors.blueAccent), // Adjust icon color
                title: Text(
                  'Recent Attendance Records',
                  style: TextStyle(color: Colors.blueAccent), // Adjust text color
                ),
              ),
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                // Navigate to AttendanceMarkingScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendanceMarkingScreen(),
                  ),
                );
              },
              child: ListTile(
                leading: Icon(Icons.check, color: Colors.green), // Adjust icon color
                title: Text(
                  'Mark Attendance',
                  style: TextStyle(color: Colors.green), // Adjust text color
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.event, color: Colors.orange), // Adjust icon color
              title: Text(
                'Upcoming Events',
                style: TextStyle(color: Colors.orange), // Adjust text color
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.notifications, color: Colors.red), // Adjust icon color
              title: Text(
                'Notifications',
                style: TextStyle(color: Colors.red), // Adjust text color
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to profile update screen
                Navigator.pushNamed(context, '/profile');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color on button
              ),
              child: Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
