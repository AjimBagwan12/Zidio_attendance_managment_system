import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AttendanceMarkingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Marking'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Manual Attendance Marking Form'),
            // Implement attendance marking form
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to QR code scanning screen
                Navigator.pushNamed(context, '/qr_scan');
              },
              child: Text('Scan QR Code'),
            ),
          ],
        ),
      ),
    );
  }
}
