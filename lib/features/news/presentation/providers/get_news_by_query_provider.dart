import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/get_news_by_query_usecase.dart';
import 'news_provider.dart';

final getNewsByQueryProvider = Provider<GetNewsByQueryUseCase>(
  (ref) {
    return GetNewsByQueryUseCase(ref.read(newsRepositoryProvider));
  },
);
