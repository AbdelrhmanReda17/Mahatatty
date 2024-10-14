import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mahattaty/features/train_booking/domain/entities/ticket.dart';
import 'package:mahattaty/features/train_booking/domain/repository/train_repository.dart';

import '../entities/train_seat.dart';

class BookTrainTicketUseCase {
  final BaseTrainRepository repository;

  BookTrainTicketUseCase(this.repository);

  Future<String> call({
    required TicketType ticketType,
    required String trainId,
    required Timestamp bookingDate,
    required SeatType seat,
    required String userId,
  }) async {
    return await repository.bookTrainTicket(
      ticketType: ticketType,
      trainId: trainId,
      bookingDate: bookingDate,
      seat: seat,
      userId: userId,
    );
  }
}
