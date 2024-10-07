import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/news/domain/usecases/get_all_news_usecase.dart';
import 'package:mahattaty/features/news/presentation/providers/news_provider.dart';

final getAllNewsProvider = Provider<GetAllNewsUseCase>(
  (ref) {
    return GetAllNewsUseCase(
      ref.read(newsRepositoryProvider),
    );
  },
);
