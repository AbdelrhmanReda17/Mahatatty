import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/news.dart';
import '../providers/get_all_news_provider.dart';

final allNewsController = FutureProvider<List<News>>((ref) {
  ref.state = const AsyncValue.loading();
  try {
    final news = ref.read(getAllNewsProvider).execute();
    return news;
  } catch (e) {
    ref.state = AsyncValue.error(e, e as StackTrace);
    rethrow;
  }
});
