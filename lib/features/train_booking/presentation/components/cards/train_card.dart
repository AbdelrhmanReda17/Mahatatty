import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/core/utils/app_localizations_extension.dart';
import 'package:mahattaty/features/train_booking/presentation/components/cards/train_ticket_card.dart';
import '../../../../../core/utils/time_converter.dart';
import '../../../domain/entities/ticket.dart';
import '../../../domain/entities/train.dart';
import '../../../domain/entities/train_seat.dart';
import '../../../../../core/generic components/count_down_timer.dart';
import 'helpers/custom_line.dart';
import 'helpers/train_price.dart';
import 'helpers/train_time_information.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TrainCard extends StatelessWidget {
  final Train? train;
  final Ticket? ticket;
  final TicketType? ticketType;
  final SeatType? seatType;
  final TrainStations departureStation;
  final TrainStations arrivalStation;
  final isShowPrice;

  final Function(Ticket?, Train?)? onTrainSelected;
  final bool displayTrainTicketCard;
  final bool isLoading;

  const TrainCard({
    super.key,
    this.train,
    this.ticket,
    this.ticketType,
    this.seatType,
    this.onTrainSelected,
    required this.departureStation,
    this.isShowPrice = true,
    required this.arrivalStation,
    this.displayTrainTicketCard = false,
    this.isLoading = true,
  });

  @override
  Widget build(BuildContext context) {
    final trainPriceData = _calculatePrice(train, ticket , seatType);
    final bool isShowTicketChard =
        ticketType != null && seatType != null && displayTrainTicketCard;


    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Container(
        margin: EdgeInsets.only(bottom: displayTrainTicketCard ? 0 : 10),
        child: InkWell(
          onTap: _handleTrainSelection,
          child: Column(
            children: [
              _buildMainContainer(context, trainPriceData),
              if (isShowTicketChard)
                TrainTicketCard(ticketType: ticketType!, seatType: seatType!),
            ],
          ),
        ),
      ),
    );
  }

  void _handleTrainSelection() {
    if (onTrainSelected != null && (ticket != null || train != null)) {
      onTrainSelected!(ticket, train);
    }
  }

  Map<String, dynamic> _calculatePrice(Train? train, Ticket? ticket , SeatType? seatType) {
    double trainPrice = 0.0;
    double discountTrainPrice = 0.0;
    bool isShowDiscount = false;

    if (train != null) {
      seatType ??= SeatType.economic;
      trainPrice = train.trainSeats
          .firstWhere((element) => element.seatType == seatType)
          .seatPrice;
      discountTrainPrice =
          trainPrice - (trainPrice * (train.seatDiscount / 100));
      isShowDiscount = train.seatDiscount != 0 &&
          train.seatDiscountDate.toDate().isAfter(DateTime.now());
    }
    if (ticket != null) {
      trainPrice = ticket.price;
      isShowDiscount = false;
    }
    return {
      'trainPrice': trainPrice,
      'discountTrainPrice': discountTrainPrice,
      'isShowDiscount': isShowDiscount,
    };
  }

  Widget _buildMainContainer(
      BuildContext context, Map<String, dynamic> trainPriceData) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (train != null && trainPriceData['isShowDiscount']) ...[
            CountdownTimer(targetDateTime: train!.seatDiscountDate.toDate()),
            const SizedBox(height: 10),
          ],
          if (train != null) _buildTrainDetails(context, trainPriceData),
          _buildStationInformation(context),
          const SizedBox(height: 15),
          if (train != null) ...[
            const CustomLine(
                isDashed: true, size: 1, dashWidth: 3, dashSpace: 3),
            const SizedBox(height: 15),
            TimeInformation(
              departureTime: train!.trainDepartureTime,
              departureDate:
                  TimeConverter.convertTimeToDate(train!.trainArrivalDate , isNumber: true),
              duration: train!.trainDuration,
              arrivalTime: train!.trainArrivalTime,
              arrivalDate:
                  TimeConverter.convertTimeToDate(train!.trainArrivalDate , isNumber: true),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTrainDetails(
      BuildContext context, Map<String, dynamic> trainPriceData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(FontAwesomeIcons.trainSubway),
            const SizedBox(width: 8),
            Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
              train!.trainName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        if(isShowPrice)
             TrainPrice(
              trainPrice: trainPriceData['trainPrice'],
              discountTrainPrice: trainPriceData['discountTrainPrice'],
              isShowDiscount: trainPriceData['isShowDiscount'],
            ),
      ],
    );
  }

  Widget _buildStationInformation(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStationColumn(context, departureStation),
        _buildStationColumn(context, arrivalStation, isRightAlign: true),
      ],
    );
  }

  Widget _buildStationColumn(BuildContext context, TrainStations station, {bool isRightAlign = false}) {
    return Column(
      crossAxisAlignment: isRightAlign ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.station(station.code),
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
        Text(
          station.code,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ],
    );
  }
}
