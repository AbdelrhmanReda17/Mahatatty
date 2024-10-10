import 'package:mahattaty/features/train_booking/domain/entities/ticket.dart';

import '../../domain/entities/train_seat.dart';

class TicketModel extends Ticket {
  TicketModel({
    required super.id,
    required super.trainId,
    required super.userId,
    required super.seatType,
    required super.status,
    required super.type,
    required super.price,
    required super.bookingDate,
  });

  factory TicketModel.fromFireStore(Map<String, dynamic> map, String id) {
    return TicketModel(
      id: id,
      trainId: map['trainId'],
      userId: map['userId'],
      seatType: SeatType.values.firstWhere(
        (element) => element.toString() == 'SeatType.${map["seatType"]}',
      ),
      status: TicketStatus.values.firstWhere(
        (element) => element.toString() == 'TicketStatus.${map["status"]}',
      ),
      type: TicketType.values.firstWhere(
        (element) => element.toString() == 'TicketType.${map["type"]}',
      ),
      price: map['price'],
      bookingDate: map['bookingDate'],
    );
  }

  @override
  String toString() {
    return 'TicketModel(id: $id, trainId: $trainId, userId: $userId, status: $status, type: $type, price: $price)';
  }
}
