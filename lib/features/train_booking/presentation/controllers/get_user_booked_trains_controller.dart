import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/authentication/presentation/providers/get_current_user_provider.dart';
import 'package:mahattaty/features/train_booking/domain/entities/ticket.dart';

import '../../domain/entities/train.dart';
import '../providers/get_user_booked_trains_provider.dart';

final getUserBookedTrainsController = FutureProvider<Map<Ticket, Train>>((ref) {
  ref.state = const AsyncValue.loading();
  try {
    final user = ref.read(getCurrentUserUseCaseProvider).call();
    final trains = user.then(
      (value) => ref.read(getUserBookedTrainsProvider).call(
            value!.uuid,
          ),
    );

    return trains;
  } catch (e) {
    ref.state = AsyncValue.error(e, e as StackTrace);
    rethrow;
  }
});
