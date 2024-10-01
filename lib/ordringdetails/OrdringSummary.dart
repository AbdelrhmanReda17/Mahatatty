import 'package:flutter/material.dart';

void main() {
  runApp(OrderSummaryApp());
}

class OrderSummaryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order Summary',
      home: OrderSummaryScreen(),
    );
  }
}

class OrderSummaryScreen extends StatelessWidget {
  // Define data at the top to be easily changeable
  final String trainName = "Pensitanian Train";
  final String price = "\$30.35";
  final String fromCity = "New York City";
  final String fromCode = "NYC";
  final String toCity = "Pennsylvania";
  final String toCode = "PNV";
  final String departureTime = "08:30 AM";
  final String arrivalTime = "10:00 AM";
  final String date = "24 Feb 2023";
  final String duration = "Duration 1h 15m";
  final String passengerName = "Passenger 1";
  final String identityType = "Passport";
  final String identityNumber = "A 38910381";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF005D63),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Ordering Summary',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.error_outline, color: Colors.white),
            onPressed: () {
              // Action for exclamation icon press
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Train Information Section
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
                  // Train name and price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        trainName,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        price,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  // From and To locations
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fromCity,
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            fromCode,
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            toCity,
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            toCode,
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  // Departure and arrival time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(departureTime),
                      Icon(Icons.train, color: Colors.teal),
                      Text(arrivalTime),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  // Duration
                  Text(
                    duration,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            // Passenger Details Section
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
                  // Passenger Name
                  Text(
                    passengerName,
                    style: TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  // Identity Type and Number
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Type of Identity",
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.grey[600]),
                            ),
                            SizedBox(height: 4.0),
                            Text(identityType),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Identity Number",
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.grey[600]),
                            ),
                            SizedBox(height: 4.0),
                            Text(identityNumber),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            // Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle continue action
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Color(0xFF005D63),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(fontSize: 18.0),
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
