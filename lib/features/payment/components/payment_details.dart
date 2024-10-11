import 'package:flutter/material.dart';
import '../../train_booking/domain/entities/ticket.dart';
import '../../train_booking/presentation/components/detail_row.dart';


import 'package:flutter/material.dart';
import '../../train_booking/domain/entities/ticket.dart';
import '../../train_booking/domain/entities/train.dart';

class PaymentDetails extends StatelessWidget {
  final Ticket ticket;
  final Train train;

  const PaymentDetails({
    Key? key,
    required this.ticket,
    required this.train,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 10),
          DetailRow(label: 'Train Name:', value: train.trainName),
          DetailRow(label: 'From:', value: train.trainDepartureStation.toString().split('.').last),
          DetailRow(label: 'To:', value: train.trainArrivalStation.toString().split('.').last),
          DetailRow(label: 'Departure Time:', value: train.trainDepartureTime),
          DetailRow(label: 'Arrival Time:', value: train.trainArrivalTime),
          DetailRow(label: 'Seat Type:', value: ticket.seatType.toString().split('.').last),
          DetailRow(label: 'Ticket Status:', value: ticket.status.toString().split('.').last),
          DetailRow(label: 'Booking Date:', value: ticket.bookingDate.toDate().toLocal().toString().split(' ')[0]),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          Text(
            'Total Price:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '\$${ticket.price.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
