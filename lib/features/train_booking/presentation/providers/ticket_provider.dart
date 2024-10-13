import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasource/tickets_remote_data_source.dart';
import '../../data/repository/ticket_repository.dart';
import '../../domain/repository/ticket_repository.dart';

final ticketRepositoryProvider = Provider<BaseTicketRepository>(
      (ref) {
    final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
    final TicketsRemoteDataSource ticketsRemoteDataSource = TicketsRemoteDataSource(firebaseFireStore);
    return TicketRepository(ticketsRemoteDataSource);
  },
);
