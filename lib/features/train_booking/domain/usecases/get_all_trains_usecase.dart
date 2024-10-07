import '../entities/train.dart';
import '../repository/train_repository.dart';

class GetAllTrainsUseCase {
  final BaseTrainRepository repository;

  GetAllTrainsUseCase(this.repository);

  Future<List<Train>> call() async {
    return repository.getAllTrains();
  }
}
