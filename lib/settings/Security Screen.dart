import 'package:flutter/material.dart';

import 'ToggleOption.dart';

class SecurityScreen extends StatefulWidget {
  @override
  _SecurityScreenState createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool faceId = true;
  bool rememberPassword = true;
  bool touchId = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Security"),
      ),
      body: Column(
        children: [
          ToggleOption(
            title: "Face ID",
            value: faceId,
            onChanged: (newValue) {
              setState(() {
                faceId = newValue;
              });
            },
          ),
          ToggleOption(
            title: "Remember Password",
            value: rememberPassword,
            onChanged: (newValue) {
              setState(() {
                rememberPassword = newValue;
              });
            },
          ),
          ToggleOption(
            title: "Touch ID",
            value: touchId,
            onChanged: (newValue) {
              setState(() {
                touchId = newValue;
              });
            },
          ),
        ],
      ),
    );
  }
}
