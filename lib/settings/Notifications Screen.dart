import 'package:flutter/material.dart';
import 'ToggleOption.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool payment = true;
  bool schedule = true;
  bool cancellation = true;
  bool notification = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: Column(
        children: [
          ToggleOption(
            title: "Payment",
            value: payment,
            onChanged: (newValue) {
              setState(() {
                payment = newValue;
              });
            },
          ),
          ToggleOption(
            title: "Schedule",
            value: schedule,
            onChanged: (newValue) {
              setState(() {
                schedule = newValue;
              });
            },
          ),
          ToggleOption(
            title: "Cancellation",
            value: cancellation,
            onChanged: (newValue) {
              setState(() {
                cancellation = newValue;
              });
            },
          ),
          ToggleOption(
            title: "Notification",
            value: notification,
            onChanged: (newValue) {
              setState(() {
                notification = newValue;
              });
            },
          ),
        ],
      ),
    );
  }
}
