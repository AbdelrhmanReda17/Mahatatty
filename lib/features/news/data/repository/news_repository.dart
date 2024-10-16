import 'package:mahattaty/features/news/data/datasource/news_remote_data_source.dart';
import 'package:mahattaty/features/news/domain/entities/news.dart';
import 'package:mahattaty/features/news/domain/repository/news_repository.dart';

class NewsRepository extends BaseNewsRepository {
  BaseNewsRemoteDataSource newsRemoteDataSource;

  NewsRepository(this.newsRemoteDataSource);

  @override
  Future<List<News>> getAllNews() {
    return newsRemoteDataSource.getAllNews();
  }

  @override
  Future<List<News>> getLatestNews() {
    return newsRemoteDataSource.getLatestNews();
  }


  @override
  Future<List<News>> getNewsByQuery(String query) {
    return newsRemoteDataSource.getNewsByQuery(query);
  }
}
