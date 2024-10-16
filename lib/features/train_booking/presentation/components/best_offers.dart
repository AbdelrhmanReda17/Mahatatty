import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/core/utils/open_screens.dart';
import 'package:mahattaty/features/train_booking/presentation/components/cards/train_card.dart';
import 'package:mahattaty/features/train_booking/presentation/controllers/best_offers_trains_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mahattaty/features/train_booking/presentation/screens/seat_selection_screen.dart';
import '../../../../core/generic components/mahattaty_empty_data.dart';
import '../../../../core/generic components/mahattaty_error.dart';
import '../../../../core/generic components/mahattaty_loading.dart';
import '../../domain/entities/ticket.dart';

class BestOffers extends ConsumerWidget {
  const BestOffers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trainsState = ref.watch(bestOffersTrainsController);
    final primary = Theme.of(context).colorScheme.primary;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.bestOffers,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primary
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: trainsState.when(
            data: (trains) {
              if (trains.isEmpty) {
                return  MahattatyEmptyData(message: AppLocalizations.of(context)!.emptyBestOffers);
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: trains.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      TrainCard(
                        train: trains[index],
                        onTrainSelected: (_, train) {
                            OpenScreen.openScreenWithSmoothAnimation(
                              context,
                              SeatSelectionScreen(
                                train: train!,
                                ticketType: TicketType.oneWay,
                              ),
                              false,
                            );
                        },
                        departureStation: trains[index].trainDepartureStation,
                        arrivalStation: trains[index].trainArrivalStation,
                        displayTrainTicketCard: false,
                      ),
                    ],
                  );
                },
              );
            },
            loading: () => const MahattatyLoading(),
            error: (_, __) => MahattatyError(
                onRetry: () => ref.refresh(bestOffersTrainsController)),
          ),
        ),
      ],
    );
  }
}
