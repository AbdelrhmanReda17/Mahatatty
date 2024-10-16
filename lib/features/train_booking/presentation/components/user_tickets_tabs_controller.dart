import 'package:flutter/material.dart';
import 'package:mahattaty/features/train_booking/presentation/components/user_tickets_done.dart';
import 'package:mahattaty/features/train_booking/presentation/components/user_tickets_upcoming.dart';
import '../../domain/entities/ticket.dart';
import '../../domain/entities/train.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserTicketsTabsController extends StatelessWidget {
  const UserTicketsTabsController({
    super.key,
    required this.tickets,
    required this.filterDate,
    required this.filterTrainType,
  });

  final Map<Ticket, Train> tickets;
  final DateTime? filterDate;
  final int filterTrainType;

  Map<Ticket, Train> _buildUpComingTickets(Map<Ticket, Train> tickets) {
    return Map.fromEntries(
      tickets.entries.where(
        (entry) {
          final train = entry.value;
          bool dateMatches = filterDate == null ||
              train.trainDepartureDate.toDate().isAfter(filterDate!);
          bool typeMatches = filterTrainType == 0 ||
              train.trainType.index == filterTrainType - 1;
          return train.trainDepartureDate.toDate().isAfter(DateTime.now()) &&
              dateMatches &&
              typeMatches;
        },
      ),
    );
  }

  Map<Ticket, Train> _buildDoneTickets(Map<Ticket, Train> tickets) {
    return Map.fromEntries(
      tickets.entries.where(
        (entry) {
          final train = entry.value;
          bool dateMatches = filterDate == null ||
              train.trainDepartureDate.toDate().isAfter(filterDate!);
          bool typeMatches = filterTrainType == 0 ||
              train.trainType.index == filterTrainType - 1;
          return train.trainDepartureDate.toDate().isBefore(DateTime.now()) &&
              dateMatches &&
              typeMatches;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<Ticket, Train> upComingTickets = _buildUpComingTickets(tickets);
    final Map<Ticket, Train> doneTickets = _buildDoneTickets(tickets);

    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TabBar(
              isScrollable: false,
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.transparent,
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              tabs:  [
                Tab(text: AppLocalizations.of(context)!.upComing),
                Tab(text: AppLocalizations.of(context)!.done),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                children: [
                  UserTicketsUpComing(tickets: upComingTickets),
                  UserTicketsDone(tickets: doneTickets),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
