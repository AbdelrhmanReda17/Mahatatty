import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/train.dart';
import '../providers/get_best_offers_trains_provider.dart';

final bestOffersTrainsController = FutureProvider<List<Train>>((ref) async {
  try {
    final trains = await ref.read(getBestOffersTrainsProvider).call();
    log('Best Offers Trains: $trains');
    return trains;
  } catch (e, stackTrace) {
    log('Error in Best Offers Trains: $e  , $stackTrace');
    rethrow;
  }
});
