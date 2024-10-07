import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/train_booking/domain/entities/ticket.dart';
import 'package:mahattaty/features/train_booking/presentation/components/search_card.dart';
import 'package:mahattaty/features/train_booking/presentation/components/search_card_form.dart';

import '../../domain/entities/train.dart';
import '../controllers/search_train_controller.dart';

class TrainSearch extends ConsumerStatefulWidget {
  const TrainSearch({super.key});

  @override
  TrainSearchState createState() => TrainSearchState();
}

class TrainSearchState extends ConsumerState<TrainSearch> {
  bool isFindTicketClicked = false;
  bool isRoundTrip = false;

  void switchForms() {
    setState(() {
      isFindTicketClicked = !isFindTicketClicked;
    });
  }

  void onRoundTripClicked(bool value) {
    ref.read(searchProvider.notifier).state =
        ref.read(searchProvider.notifier).state.copyWith(
              ticketType: value ? TicketType.roundTrip : TicketType.oneWay,
            );
    setState(() {
      isRoundTrip = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    void onSearchClicked() {
      final search = ref.read(searchProvider);
      log('onSearchClicked');
      log(search.toString());
    }

    return AnimatedSwitcher(
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: !isFindTicketClicked
          ? SearchCard(switchForms: switchForms)
          : SearchCardForm(
              switchForms: switchForms,
              onRoundTripClicked: onRoundTripClicked,
              isRoundTrip: isRoundTrip,
              onSearchClicked: onSearchClicked,
            ),
    );
  }
}
