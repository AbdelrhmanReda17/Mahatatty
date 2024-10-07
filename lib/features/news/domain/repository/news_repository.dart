import '../entities/news.dart';

abstract class BaseNewsRepository {
  Future<List<News>> getLatestNews();

  Future<List<News>> getNewsByCategory(String category);

  Future<List<News>> getNewsByQuery(String query);

  Future<List<News>> getAllNews();
}
