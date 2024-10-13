import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mahattaty/features/train_booking/domain/entities/ticket.dart';

import '../models/ticket_model.dart';

abstract class BaseTicketRemoteDataSource {

  Future<Ticket> getTicketByTrainId(String trainId);
}

class TicketsRemoteDataSource implements BaseTicketRemoteDataSource {
  final FirebaseFirestore fireStore;

  TicketsRemoteDataSource(this.fireStore);

  @override
  Future<TicketModel> getTicketByTrainId(String trainId) async{
    try{
      final ticketSnapshot = await fireStore.collection('tickets').where('trainId', isEqualTo: trainId).get();
      if (ticketSnapshot.docs.isNotEmpty) {
        return TicketModel.fromFireStore(
            ticketSnapshot.docs.first.data(), ticketSnapshot.docs.first.id);
      }
      throw Exception('There is no Tickets for this Train');
    }
    catch(e){
      throw Exception('Error Fetching Thicket Data: $e');
    }
  }
}