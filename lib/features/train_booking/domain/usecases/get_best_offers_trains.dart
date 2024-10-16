import 'package:mahattaty/features/train_booking/domain/repository/train_repository.dart';
import '../entities/train.dart';

class GetBestOffersTrainsUseCase {
  final BaseTrainRepository repository;

  GetBestOffersTrainsUseCase(this.repository);

  Future<List<Train>> call() async {
    return await repository.getBestOffersTrains();
  }
}
