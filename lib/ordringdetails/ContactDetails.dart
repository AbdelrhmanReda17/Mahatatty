import 'package:flutter/material.dart';

void main() {
  runApp(ContactDetailApp());
}

class ContactDetailApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Detail',
      home: ContactDetailScreen(),
    );
  }
}

class ContactDetailScreen extends StatefulWidget {
  @override
  _ContactDetailScreenState createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  // Define data at the top to be easily changeable
  final String fullName = "Saski Ropokova";
  final String emailAddress = "Saski.topokova998@gmail.com";
  final String mobilePhone = "+1 2345 7789 908";

  bool agree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF005D63), // Set background color to match the design
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Custom back arrow icon
          onPressed: () {
            Navigator.of(context).pop(); // Define what happens when the back button is pressed
          },
        ),
        title: Text(
          'Contact Detail',
          style: TextStyle(
            color: Colors.white, // Title text color
            fontSize: 18, // Title text size
          ),
        ),
        centerTitle: true, // Align the title in the center
        actions: [
          IconButton(
            icon: Icon(Icons.error_outline, color: Colors.white), // Exclamation icon
            onPressed: () {
              // Define what happens when the exclamation icon is pressed
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Contact Information Section
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Full Name
                  Text(
                    "Full Name",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700]),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.teal),
                      SizedBox(width: 8.0),
                      Text(
                        fullName,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  // Email Address
                  Text(
                    "Email Address",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700]),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.email, color: Colors.teal),
                      SizedBox(width: 8.0),
                      Text(
                        emailAddress,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  // Mobile Phone
                  Text(
                    "Mobile Phone",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700]),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.teal),
                      SizedBox(width: 8.0),
                      Text(
                        mobilePhone,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            // Checkbox for agreement
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: agree,
                    onChanged: (bool? value) {
                      setState(() {
                        agree = value ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      'I hereby agree to be the person contacted by the airline, should something happen.',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            // Terms of Service and Privacy Policy Text
            Text(
              'By clicking "Continue", I accept the Terms of Service and have read the Privacy Policy. I agree that Pegitrain may share my information.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
            ),
            SizedBox(height: 20.0),
            // Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: agree
                    ? () {
                  // Handle continue action here
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Color(0xFF005D63),
                  disabledBackgroundColor: Colors.grey,
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFFEFEFEF),
    );
  }
}
