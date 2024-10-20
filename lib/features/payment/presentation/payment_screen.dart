import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/core/utils/open_dialogs.dart';
import '../../../core/generic components/mahattaty_alert.dart';
import '../../../core/generic components/mahattaty_button.dart';
import '../../../core/generic components/mahattaty_scaffold.dart';
import '../../screens/root_screen.dart';
import '../../train_booking/domain/entities/ticket.dart';
import '../../train_booking/domain/entities/train.dart';
import '../../train_booking/domain/entities/train_seat.dart';
import '../../train_booking/presentation/components/cards/train_card.dart';
import '../../train_booking/presentation/controllers/book_ticket_controller.dart';
import '../../../core/generic components/count_down_timer.dart';
import '../components/payment_method_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  final Train train;
  final TicketType ticketType;
  final SeatType seatType;
  final String ticketId;

  const PaymentScreen({
    super.key,
    required this.train,
    required this.ticketType,
    required this.seatType,
    required this.ticketId,
  });

  @override
  PaymentScreenState createState() => PaymentScreenState();
}

class PaymentScreenState extends ConsumerState<PaymentScreen> {
  bool isDialog = false;

  void handleDialog() {
    setState(() {
      isDialog = !isDialog;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<BookingTicketState>(
      bookTicketControllerProvider,
          (previous, next) {
        if (next.error != null){
          mahattatyAlertDialog(
            context,
            message: next.error!,
            type: MahattatyAlertType.error,
          );
        }

      },
    );

    final surface = Theme.of(context).colorScheme.surface;
    final primary = Theme.of(context).colorScheme.primary;
    final paymentState = ref.watch(bookTicketControllerProvider);
    return MahattatyScaffold(
      onWillPop: () async {
        await ref.watch(bookTicketControllerProvider.notifier).cancelTicket(
          widget.ticketId,
        );
        Navigator.of(context).popUntil(
          (route) {
            return route.settings.name == const RootScreen().homeRouteName;
          },
        );
        return true;
      },
      appBarContent:  Text(
        AppLocalizations.of(context)!.payment,
        style: TextStyle(color:surface),
      ),
      bgHeight: backgroundHeight.large,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.paymentInfo,
              style: TextStyle(
                color: surface,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            CountdownTimer(
              onTimerEnd: () async =>  {
                await ref.watch(bookTicketControllerProvider.notifier).cancelTicket(
                      widget.ticketId,
                    ),
                Navigator.of(context).popUntil(
                  (route) {
                    return route.settings.name ==
                        const RootScreen().homeRouteName;
                  },
                ),
              },
              targetDateTime: DateTime.now().add(const Duration(minutes: 5)),
            ),
            const SizedBox(height: 20),
            TrainCard(
              train: widget.train,
              ticketType: widget.ticketType,
              seatType: widget.seatType,
              departureStation: widget.train.trainDepartureStation,
              arrivalStation: widget.train.trainArrivalStation,
              displayTrainTicketCard: true,
            ),
            const SizedBox(height: 20),
            MahattatyButton(
              style: MahattatyButtonStyle.primary,
              text: AppLocalizations.of(context)!.payNow,
              disabled: paymentState.isLoading,
              onPressed: () {
                handleDialog();
                OpenDialogs.openCustomDialog(
                  context: context,
                  dialog: PaymentMethodDialog(
                    ticketId: widget.ticketId,
                    onClose: () {
                      Navigator.of(context).popUntil(
                            (route) {
                          return route.settings.name == const RootScreen().homeRouteName;
                        },
                      );
                    },
                  ),
                );
              },
              backgroundColor:primary,
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
