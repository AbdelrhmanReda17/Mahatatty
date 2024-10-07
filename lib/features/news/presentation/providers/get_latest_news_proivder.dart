import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/news/domain/usecases/get_latest_news_usecase.dart';

import 'news_provider.dart';

final getLatestNewsProvider = Provider<GetLatestNewsUseCase>(
  (ref) {
    return GetLatestNewsUseCase(ref.read(newsRepositoryProvider));
  },
);
