import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/news.dart';
import '../providers/get_latest_news_proivder.dart';

final latestNewsController = FutureProvider<List<News>>((ref) {
  ref.state = const AsyncValue.loading();
  try {
    final news = ref.read(getLatestNewsProvider).execute();
    return news;
  } catch (e) {
    ref.state = AsyncValue.error(e, e as StackTrace);
    rethrow;
  }
});
