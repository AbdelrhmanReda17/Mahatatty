import 'package:mahattaty/features/train_booking/domain/repository/train_repository.dart';

import '../entities/train.dart';

class GetTrainById{
  final BaseTrainRepository repository;

  GetTrainById(this.repository);

  Future<Train> call({required String trainId}) async{
    return await repository.getTrainById(trainId);
  }
}