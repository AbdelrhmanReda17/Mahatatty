import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/train_booking/data/datasource/trains_remote_data_source.dart';
import 'package:mahattaty/features/train_booking/data/repository/train_repository.dart';
import 'package:mahattaty/features/train_booking/domain/repository/train_repository.dart';

final trainRepositoryProvider = Provider<BaseTrainRepository>(
  (ref) {
    final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
    firebaseFireStore.settings = const Settings(persistenceEnabled: false);
    final TrainsRemoteDataSource newsRemoteDataSource =
        TrainsRemoteDataSource(firebaseFireStore);
    return TrainRepository(newsRemoteDataSource);
  },
);
