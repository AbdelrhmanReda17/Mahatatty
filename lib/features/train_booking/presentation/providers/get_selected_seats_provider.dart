import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/train_booking/domain/entities/train_seat.dart';

final selectedSeatsProvider = StateProvider<List<TrainSeats>>((ref) => []);

void selectSeat(WidgetRef ref, TrainSeats seat){
  final selectedSeatsNotifier = ref.read(selectedSeatsProvider.notifier);
  final selectedSeats = ref.read(selectedSeatsProvider);

  if (!selectedSeats.contains(seat)) {
    selectedSeatsNotifier.state = [...selectedSeats, seat];
  } else {
    // Remove seat from selectedSeats if it's already selected
    selectedSeatsNotifier.state = selectedSeats.where((s) => s != seat).toList();
  }
}

// Function to clear selected seats (for example, after booking)
void clearSelectedSeats(WidgetRef ref) {
  ref.read(selectedSeatsProvider.notifier).state = [];
}

