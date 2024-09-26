import 'package:flutter/material.dart';

class ProfileUpdateScreen extends StatefulWidget {
  @override
  _ProfileUpdateScreenState createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  // Controllers for text fields
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  } else if (!value.contains('@')) {
                    return 'Invalid email format';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Validate form
                  if (_formKey.currentState!.validate()) {
                    // Process form data (e.g., update profile in backend)
                    _updateProfile();
                  }
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to update profile (dummy method)
  void _updateProfile() {
    String name = _nameController.text;
    String email = _emailController.text;

    // Replace with actual logic to update profile (e.g., update in database)
    print('Updating profile: Name - $name, Email - $email');

    // Show success message (can be a Snackbar or navigate back)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile updated successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    // Clean up controllers when widget is disposed
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
