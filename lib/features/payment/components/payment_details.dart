/*import 'package:flutter/material.dart';
import '../../domain/entities/ticket.dart';
import 'detail_row.dart';

class PaymentDetails extends StatelessWidget {
  final Ticket ticket;

  const PaymentDetails({Key? key, required this.ticket}) : super(key: key);

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
            offset: Offset(0, 2),
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
          DetailRow(label: 'Train Name:', value: 'Train ${ticket.trainId}'),
          DetailRow(label: 'From:', value: ticket.from),
          DetailRow(label: 'To:', value: ticket.to),
          DetailRow(label: 'Departure:', value: ticket.departure),
          DetailRow(label: 'Arrival:', value: ticket.arrival),
          DetailRow(label: 'Duration:', value: ticket.duration),
          DetailRow(label: 'Seat Number:', value: ticket.seatNumber),
          const SizedBox(height: 10),
          Divider(),
          const SizedBox(height: 10),
          Text(
            'Total Price:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '\$${ticket.price}',
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
}*/
