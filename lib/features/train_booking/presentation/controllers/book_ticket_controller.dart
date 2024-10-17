import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/train_booking/domain/entities/train_seat.dart';
import 'package:mahattaty/features/train_booking/domain/usecases/cancel_train_ticket.dart';
import 'package:mahattaty/features/train_booking/domain/usecases/change_train_ticket_status.dart';
import 'package:mahattaty/features/train_booking/presentation/providers/change_train_ticket_status_provider.dart';

import '../../domain/entities/ticket.dart';
import '../../domain/usecases/book_train_ticket.dart';
import '../providers/book_train_ticket_provider.dart';
import '../providers/cancel_train_ticket_provider.dart';

class BookingTicketState {
  bool isLoading = false;
  String? ticketId;
  String? error;

  BookingTicketState({
    this.isLoading = false,
    this.ticketId,
    this.error,
  });

  @override
  String toString() {
    return 'Ticket ID: $ticketId';
  }
}

class BookTicketController extends StateNotifier<BookingTicketState> {
  final BookTrainTicketUseCase bookTrainTicket;
  final CancelTrainTicketUseCase cancelTrainTicketUseCase;
  final ChangeTrainTicketStatusUseCase changeTrainTicketStatusUseCase;

  BookTicketController(this.bookTrainTicket, this.cancelTrainTicketUseCase,
      this.changeTrainTicketStatusUseCase)
      : super(BookingTicketState());

  Future<void> bookTicket({
    required TicketType ticketType,
    required String trainId,
    required Timestamp bookingDate,
    required SeatType seat,
    required String userId,
  }) async {
    try {
      state = BookingTicketState(isLoading: true);
      final result = await bookTrainTicket.call(
        ticketType: ticketType,
        trainId: trainId,
        bookingDate: bookingDate,
        seat: seat,
        userId: userId,
      );
      state = BookingTicketState(ticketId: result);
    } catch (e) {
      state = BookingTicketState(error: e.toString() ,isLoading: false);
    }
  }

  Future<void> changeTicketStatus(String ticketId, TicketStatus status) async {
    try {
      state = BookingTicketState(isLoading: true);
      final result = await changeTrainTicketStatusUseCase.call(
        ticketId: ticketId,
        status: status,
      );
      state = BookingTicketState(isLoading: false);
      return result;
    } catch (e) {
      state = BookingTicketState(error: e.toString());
    }
  }

  Future<void> cancelTicket(String ticketId) async {
    try {
      state = BookingTicketState(isLoading: true);
      final result = await cancelTrainTicketUseCase.call(ticketId);
      return result;
    } catch (e) {
      state = BookingTicketState(error: e.toString());
    }
  }
}

final bookTicketControllerProvider =
    StateNotifierProvider.autoDispose<BookTicketController, BookingTicketState>(
  (ref) {
    final bookTrainTicket = ref.read(bookTrainTicketProvider);
    final cancelTrainTicketUseCase = ref.read(cancelTrainTicketProvider);
    final changeTrainTicketStatusUseCase =
        ref.read(changeTrainTicketStatusProvider);
    return BookTicketController(bookTrainTicket, cancelTrainTicketUseCase,
        changeTrainTicketStatusUseCase);
  },
);
