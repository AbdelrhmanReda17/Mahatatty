import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/news.dart';
import '../providers/get_news_by_query_provider.dart';

final newsByQueryController =
    FutureProvider.family<List<News>, String>((ref, query) {
  ref.state = const AsyncValue.loading();
  try {
    final news = ref.read(getNewsByQueryProvider).execute(query);
    return news;
  } catch (e) {
    ref.state = AsyncValue.error(e, e as StackTrace);
    rethrow;
  }
});
