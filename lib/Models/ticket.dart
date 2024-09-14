import 'package:mahattaty/Utils/constant.dart';

enum TicketType { firstClass, secondClass, thirdClass }

enum TicketStatus { booked, canceled, completed }

class Ticket {
  final String id;
  final String trainId;
  final String userId;
  final String from;
  final String to;
  final String departure;
  final String arrival;
  final String duration;
  final String price;
  final DateTime createdAt;
  final TicketType type;
  TicketStatus status;
  final String seatNumber;

  Ticket({
    required this.trainId,
    required this.userId,
    required this.from,
    required this.to,
    required this.departure,
    required this.arrival,
    required this.duration,
    required this.price,
    required this.type,
    required this.seatNumber,
    required this.status,
  })  : createdAt = DateTime.now(),
        id = uuid.v4();
}
