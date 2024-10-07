import 'package:mahattaty/features/train_booking/domain/repository/train_repository.dart';

import '../../data/repository/train_repository.dart';
import '../entities/train.dart';

class GetBestOffersTrains {
  final BaseTrainRepository repository;

  GetBestOffersTrains(this.repository);

  Future<List<Train>> call() async {
    return await repository.getBestOffersTrains();
  }
}
