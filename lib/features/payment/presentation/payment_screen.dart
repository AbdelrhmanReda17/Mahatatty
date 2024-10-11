import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Themes/dark_theme.dart';
import '../../../Themes/light_theme.dart';
import '../../../core/generic components/mahattaty_scaffold.dart';
import '../../train_booking/domain/entities/ticket.dart';
import '../../train_booking/domain/entities/train.dart';
import '../../train_booking/domain/entities/train_seat.dart';
import '../components/payment_screen_body.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mahattaty Payment',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const PaymentScreen(),
    );
  }
}

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TrainSeats sampleTrainSeat = TrainSeats(
      numberOfSeats: 1,
      seatType: SeatType.economic,
      seatPrice: 25.00,
    );

    Train sampleTrain = Train(
      'train_001',
      trainName: 'Express Train',
      trainNumber: 'EX123',
      trainType: TrainType.express,
      trainDepartureTime: '08:30',
      trainArrivalTime: '10:30',
      trainSeats: [sampleTrainSeat],
      trainBookedSeats: 1,
      trainSeatsStatus: TrainSeatsStatus.booked,
      trainTotalSeats: 100,
      trainDepartureStation: TrainStations.cairo,
      trainArrivalStation: TrainStations.alexandria,
      seatDiscountDate: Timestamp.now(),
      trainDepartureDate: Timestamp.fromDate(DateTime.parse('2024-10-24')),
      trainArrivalDate: Timestamp.fromDate(DateTime.parse('2024-10-24')),
      trainDuration: '2 hours',
      trainStatus: TrainStatus.onTime,
    );

    Ticket sampleTicket = Ticket(
      id: 'ticket_001',
      trainId: sampleTrain.id,
      userId: 'user_001',
      seatType: SeatType.economic,
      status: TicketStatus.booked,
      type: TicketType.oneWay,
      price: sampleTrainSeat.seatPrice,
      bookingDate: Timestamp.now(),
    );

    String remainingTime = getRemainingTime(DateTime.parse('2024-10-24 08:30:00'));
    return MahattatyScaffold(
      appBarContent: const CenterAppBarTitle(),
      bgHeight: backgroundHeight.large,
      body: PaymentScreenBody(
        sampleTicket: sampleTicket,
        remainingTime: remainingTime,
        sampleTrain: sampleTrain,
      ),
    );
  }
}

String getRemainingTime(DateTime departureDateTime) {
  final DateTime now = DateTime.now();
  final Duration difference = departureDateTime.difference(now);

  if (difference.isNegative) {
    return "Departed";
  }

  final int days = difference.inDays;
  final int hours = difference.inHours % 24;
  final int minutes = difference.inMinutes % 60;

  return "$days d $hours h $minutes m";
}

class CenterAppBarTitle extends StatelessWidget {
  const CenterAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Payment',
            style: TextStyle(
              color: Theme.of(context).colorScheme.surface,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
