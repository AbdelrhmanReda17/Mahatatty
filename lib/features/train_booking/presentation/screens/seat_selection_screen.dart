import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/authentication/presentation/controllers/auth_controller.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_button.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_scaffold.dart';
import 'package:mahattaty/core/utils/open_screens.dart';
import 'package:mahattaty/features/payment/presentation/payment_screen.dart';
import '../../../../core/generic components/mahattaty_alert.dart';
import '../../domain/entities/ticket.dart';
import '../../domain/entities/train.dart';
import '../components/cards/train_card.dart';
import '../controllers/book_ticket_controller.dart';

class SeatSelectionScreen extends ConsumerStatefulWidget {
  final Train train;
  final TicketType ticketType;

  const SeatSelectionScreen(
      {super.key, required this.train, required this.ticketType});

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
      appBarContent: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Text(
              'Select Your Seat',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      bgHeight: backgroundHeight.small,
      body: Padding(
        padding: const EdgeInsets.only(left: 2, right: 2, top: 10),
        child: Column(
          children: [
            TrainCard(
              train: widget.train,
              departureStation: widget.train.trainDepartureStation,
              arrivalStation: widget.train.trainArrivalStation,
            ),
            RichText(
              text: TextSpan(
                text: 'Train Seats',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            ...widget.train.trainSeats.map(
              (seat) {
                return ListTile(
                  onTap: null,
                  title: Text(
                    seat.seatType.name,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    '\$${seat.seatPrice}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                      'Remaining Seats: ${seat.numberOfSeats - seat.bookedSeats}'),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Select your Seat :',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...widget.train.trainSeats.map(
                  (seat) {
                    return ChoiceChip.elevated(
                      padding: const EdgeInsets.all(8.0),
                      label: Text(
                        seat.seatType.name,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      disabledColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                      selectedColor: Theme.of(context).colorScheme.primary,
                      selected: _isSeatSelected ==
                          widget.train.trainSeats.indexOf(seat),
                      onSelected: (seat.numberOfSeats != seat.bookedSeats)
                          ? (selected) {
                              _onSelected(
                                  widget.train.trainSeats.indexOf(seat));
                            }
                          : null,
                    );
                  },
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Price:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${widget.train.trainSeats[_isSeatSelected].seatPrice}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
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
                    text: 'Cancel',
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
                            seat: widget
                                .train.trainSeats[_isSeatSelected].seatType,
                            userId:
                                ref.watch(authControllerProvider).user!.uuid,
                          );

                      if (ref.watch(bookTicketControllerProvider).error ==
                          null) {
                        OpenScreen.openScreenWithSmoothAnimation(
                          context,
                          PaymentScreen(
                            train: widget.train,
                            ticketType: widget.ticketType,
                            seatType: widget
                                .train.trainSeats[_isSeatSelected].seatType,
                            ticketId: ref
                                .watch(bookTicketControllerProvider)
                                .ticketId!,
                          ),
                          true,
                        );
                      }
                    },
                    style: MahattatyButtonStyle.primary,
                    text: 'Confirm Seats',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
