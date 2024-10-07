import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mahattaty/features/train_booking/domain/entities/train_seat.dart';

enum TicketType {
  oneWay,
  roundTrip,
}

enum TicketStatus {
  booked,
  canceled,
}

class Ticket {
  final String id;
  final String trainId;
  final String userId;
  final SeatType seatType;
  final TicketStatus status;
  final TicketType type;
  final double price;
  final Timestamp bookingDate;

  Ticket({
    required this.id,
    required this.trainId,
    required this.userId,
    required this.seatType,
    required this.status,
    required this.type,
    required this.price,
    required this.bookingDate,
  });

  @override
  String toString() {
    return 'Ticket(id: $id, trainId: $trainId, userId: $userId, status: $status, type: $type, price: $price)';
  }
}
