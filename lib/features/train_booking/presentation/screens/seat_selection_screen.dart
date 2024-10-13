import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_scaffold.dart';
import 'package:mahattaty/features/train_booking/presentation/providers/get_selected_seats_provider.dart';

import '../../domain/entities/train_seat.dart';
import '../providers/get_train_by_id_provider.dart';

class SeatSelectionScreen extends ConsumerWidget{
  final String trainId;

  const SeatSelectionScreen({super.key, required this.trainId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTrain = ref.watch(getTrainByIdProvider(trainId));
    final seats = ref.watch(selectedSeatsProvider);

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
                fontWeight: FontWeight.bold
              ),
            )
          ],
        )
      ),
      bgHeight: backgroundHeight.small,
      body: Padding(
        padding: const EdgeInsets.only(left: 2, right: 2, top: 10),
        child: Column(
          children: [
            selectedTrain.when(
              data: (train) {
                return Column(
                  children: [
                    ...train.trainSeats.map((seat) {
                      final isSelected = seats.contains(seat);
                      return ListTile(
                        title: Text('${seat.seatType.name} - \$${seat.seatPrice}'),
                        subtitle: Text('Available seats: ${seat.numberOfSeats}'),
                        trailing: Icon(
                          isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                          color: isSelected ? Colors.green : null,
                        ),
                        onTap: () {
                          selectSeat(ref, seat);
                        },
                      );
                    }),

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
                            '\$${_calculateTotalPrice(seats)}',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                    // Confirm selection button
                    ElevatedButton(
                      onPressed: seats.isNotEmpty
                          ? () {
                        // Handle seat confirmation
                        _confirmSeats(ref, seats);
                      }
                          : null,
                      child: const Text('Confirm Seats'),
                    ),
                  ],
                  );
                },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            )
          ],
        ),
      )
    );
  }

  double _calculateTotalPrice(List<TrainSeats> selectedSeats) {
    return selectedSeats.fold(0, (sum, seat) => sum + seat.seatPrice);
  }

  void _confirmSeats(WidgetRef ref, List<TrainSeats> selectedSeats) {
    clearSelectedSeats(ref); // Clear selected seats after confirmation
  }

}