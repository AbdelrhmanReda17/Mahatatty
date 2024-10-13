import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/train_booking/domain/entities/ticket.dart';
import 'package:mahattaty/features/train_booking/presentation/providers/ticket_provider.dart';


final getTicketByTrainId = FutureProvider.family<Ticket, String>((ref, trainId) async {
  final repository = ref.read(ticketRepositoryProvider);
  final train = await repository.getTicketByTrainId(trainId);
  return train;
});