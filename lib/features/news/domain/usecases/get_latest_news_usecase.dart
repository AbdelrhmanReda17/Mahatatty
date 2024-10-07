import '../entities/news.dart';
import '../repository/news_repository.dart';

class GetLatestNewsUseCase {
  final BaseNewsRepository _newsRepository;

  GetLatestNewsUseCase(this._newsRepository);

  Future<List<News>> execute() async {
    return await _newsRepository.getLatestNews();
  }
}
