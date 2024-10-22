import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/authentication/presentation/controllers/auth_controller.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_button.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_scaffold.dart';
import 'package:mahattaty/core/utils/app_localizations_extension.dart';
import 'package:mahattaty/core/utils/open_screens.dart';
import 'package:mahattaty/features/payment/presentation/payment_screen.dart';
import '../../../../core/generic components/mahattaty_alert.dart';
import '../../domain/entities/ticket.dart';
import '../../domain/entities/train.dart';
import '../components/cards/helpers/train_price.dart';
import '../components/cards/train_card.dart';
import '../controllers/book_ticket_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SeatSelectionScreen extends ConsumerStatefulWidget {
  final Train train;
  final TicketType ticketType;

  const SeatSelectionScreen({super.key, required this.train, required this.ticketType});

  @override
  SeatSelectionScreenState createState() => SeatSelectionScreenState();
}

class SeatSelectionScreenState extends ConsumerState<SeatSelectionScreen> {
  late int _isSeatSelected;

  @override
  void initState() {
    super.initState();
    _isSeatSelected = widget.train.trainSeats.indexWhere(
      (element) => element.numberOfSeats != element.bookedSeats,
    );
  }

  void _onSelected(int selected) {
    setState(() {
      _isSeatSelected = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final onPrimaryContainer = Theme.of(context).colorScheme.onPrimaryContainer;
    final surface = Theme.of(context).colorScheme.surface;
    ref.listen(
      bookTicketControllerProvider,
      (old, next) {
        if (next.error != null) {
          mahattatyAlertDialog(
            context,
            message: next.error!,
            type: MahattatyAlertType.error,
          );
        }
      },
    );

    return MahattatyScaffold(
      bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
       children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.totalPrice,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TrainPrice(
                  trainPrice: widget.train.trainSeats[_isSeatSelected].seatPrice,
                  discountTrainPrice: widget.train.trainSeats[_isSeatSelected].seatPrice - ( widget.train.trainSeats[_isSeatSelected].seatPrice * widget.train.seatDiscount / 100),
                  isShowDiscount: true,
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: MahattatyButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: MahattatyButtonStyle.secondary,
                  textStyle: TextStyle(
                    color: primary,
                  ),
                  text: AppLocalizations.of(context)!.cancelButton,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: MahattatyButton(
                  disabled: ref.watch(bookTicketControllerProvider).isLoading,
                  onPressed: () async {
                    await ref
                        .watch(bookTicketControllerProvider.notifier)
                        .bookTicket(
                      ticketType: widget.ticketType,
                      trainId: widget.train.id,
                      bookingDate: Timestamp.now(),
                      seat: widget.train.trainSeats[_isSeatSelected].seatType,
                      userId: ref.watch(authControllerProvider).user!.uuid,
                    );

                    if (ref.watch(bookTicketControllerProvider).error == null) {
                      OpenScreen.openScreenWithSmoothAnimation(
                        context,
                        PaymentScreen(
                          train: widget.train,
                          ticketType: widget.ticketType,
                          seatType:
                          widget.train.trainSeats[_isSeatSelected].seatType,
                          ticketId:
                          ref.watch(bookTicketControllerProvider).ticketId!,
                        ),
                        true,
                      );
                    }
                  },
                  style: MahattatyButtonStyle.primary,
                  text: AppLocalizations.of(context)!.confirmButton,
                ),
              ),

            ],
          ),
        ]
      ),
      appBarContent: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Text(
              AppLocalizations.of(context)!.selectSeat,
              style: TextStyle(
                  color: surface,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      bgHeight: backgroundHeight.small,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TrainCard(
                train: widget.train,
                departureStation: widget.train.trainDepartureStation,
                arrivalStation: widget.train.trainArrivalStation,
                isShowPrice: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0 , right: 8.0),
              child: Text(
                AppLocalizations.of(context)!.trainSeats,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ...widget.train.trainSeats.map(
              (seat) {
                return ListTile(
                  onTap: null,
                  title: Text(
                    AppLocalizations.of(context)!.seat(
                      seat.seatType,
                    ),
                    style: TextStyle(
                      color: primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    '${AppLocalizations.of(context)!.arabicOrEnglish(seat.seatPrice)}  ${AppLocalizations.of(context)!.egp}',
                    style: TextStyle(
                      color: primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                      '${AppLocalizations.of(context)!.remainingSeats} ${AppLocalizations.of(context)!.arabicOrEnglish(seat.numberOfSeats - seat.bookedSeats)}'),
                );
              },
            ),
             Padding(
              padding:const EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context)!.selectSeat,
                style:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _selectSeatWidget(context , primary , onPrimaryContainer),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRowOrColumn(BuildContext context, List<Widget> body) {
    if (MediaQuery.of(context).size.width > 350) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: body,
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: body,
      );
    }
  }

  Widget _selectSeatWidget(BuildContext context , Color primary , Color onPrimaryContainer) {
    return _buildRowOrColumn(context, [
      ...widget.train.trainSeats.map(
        (seat) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            child: ChoiceChip.elevated(
              padding: const EdgeInsets.all(8.0),
              label: Text(
                AppLocalizations.of(context)!.seat(seat.seatType),
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              disabledColor: onPrimaryContainer,
              selectedColor: primary,
              selected: _isSeatSelected == widget.train.trainSeats.indexOf(seat),
              onSelected: (seat.numberOfSeats != seat.bookedSeats)
                  ? (selected) {
                      _onSelected(widget.train.trainSeats.indexOf(seat));
                    }
                  : null,
            ),
          );
        },
      ),
    ]);
  }
}
