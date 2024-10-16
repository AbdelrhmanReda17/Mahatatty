import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasource/news_remote_data_source.dart';
import '../../data/repository/news_repository.dart';
import '../../domain/repository/news_repository.dart';

final newsRepositoryProvider = Provider<BaseNewsRepository>(
  (ref) {
    final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
    firebaseFireStore.settings = const Settings(persistenceEnabled: false);
    final BaseNewsRemoteDataSource newsRemoteDataSource =
        NewsRemoteDataSource(firebaseFireStore);
    return NewsRepository(newsRemoteDataSource);
  },
);
