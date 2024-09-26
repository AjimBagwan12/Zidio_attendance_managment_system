import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    checkCurrentUser(); // Check if user is already logged in
  }

  void checkCurrentUser() async {
    User? user = _auth.currentUser;
    if (user != null) {
      // If user is already authenticated, navigate to dashboard or home screen
      Future.microtask(() {
        Navigator.pushReplacementNamed(context, '/dashboard');
      });
    }
  }

  Future<void> _login(BuildContext context) async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print('Logged in user : ${userCredential.user!.uid}');

      // Use Future.microtask to ensure navigation happens after the current frame
      Future.microtask(() {
        Navigator.pushReplacementNamed(
          context,
          '/dashboard',
          arguments: 'Login successful!', // Pass your success message here
        );
      });
    } catch (e) {
      print('Login failed : $e');
      // Handle login failure
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: $e'),
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
            'Login',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.grey.shade900, // Darker shade of black for the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.email),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.lock),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _login(context); // Call _login method to handle login process
                },
                child: Text('Login'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Future.microtask(() => Navigator.pushNamed(context, '/signup'));
                },
                child: Text(
                  'Create an Account',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Future.microtask(() => Navigator.pushNamed(context, '/phoneLogin'));
                },
                child: Text('Login with Phone Number'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
