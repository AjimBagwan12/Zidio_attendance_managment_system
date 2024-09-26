import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneLoginScreen extends StatefulWidget {
  @override
  _PhoneLoginScreenState createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  String? _verificationId;

  Future<void> _verifyPhoneNumber(BuildContext context) async {
    final String phoneNumber = _phoneController.text.trim();

    if (phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your phone number'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          Navigator.pushReplacementNamed(context, '/dashboard');
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Verification failed: ${e.message}'),
              backgroundColor: Colors.red,
            ),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Verification code sent'),
              backgroundColor: Colors.green,
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _verificationId = verificationId;
          });
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Phone number verification failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _signInWithPhoneNumber(BuildContext context) async {
    final String smsCode = _codeController.text.trim();

    if (_verificationId == null || smsCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter the verification code'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );

      await _auth.signInWithCredential(credential);
      Navigator.pushReplacementNamed(context, '/dashboard');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign-in failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900, // Medium black background color
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.0),
          child: Text(
            'Login with Phone Number',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.grey.shade900, // Darker shade of black for the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Enter your phone number',
                prefixIcon: Icon(Icons.phone),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _verifyPhoneNumber(context); // Call _verifyPhoneNumber method to start verification process
              },
              child: Text('Send Verification Code'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _codeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter the verification code',
                prefixIcon: Icon(Icons.message),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _signInWithPhoneNumber(context); // Call _signInWithPhoneNumber method to complete login process
              },
              child: Text('Verify & Login'),
            ),
          ],
        ),
      ),
    );
  }
}
