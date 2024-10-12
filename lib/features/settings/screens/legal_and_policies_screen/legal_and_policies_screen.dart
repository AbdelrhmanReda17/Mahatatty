import 'package:flutter/material.dart';

class LegalAndPoliciesScreen extends StatelessWidget {
  const LegalAndPoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Legal and Policies"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Additional options can be handled here.
            },
          ),
        ],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Terms",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              // Terms content
              "This app, 'BookTrain Tacet', offers users an immersive reading "
                  "experience during their train journeys. Users can access a wide range of books "
                  "while offline, ensuring entertainment throughout their trip. By using this app, "
                  "users agree not to redistribute or share any content without the publisher's consent."
                  " BookTrain Tacet holds no responsibility for external content accessed through third-party links.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              "Changes to the Service and/or Terms",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "BookTrain Tacet reserves the right to update, modify, or change the "
                  "content available in the app, as well as the terms and conditions, at any time. "
                  "Users will be notified of major updates. By continuing to use the app, users accept these"
                  " changes and agree to any updated terms.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              "Privacy Policy",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "BookTrain Tacet respects user privacy. We do not collect personal data "
                  "without consent. Data collected, such as reading preferences, will be used "
                  "to improve user experience. No information is shared with third parties",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
