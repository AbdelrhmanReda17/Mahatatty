import '../entities/news.dart';
import '../repository/news_repository.dart';

class GetNewsByQueryUseCase {
  final BaseNewsRepository _newsRepository;

  GetNewsByQueryUseCase(this._newsRepository);

  Future<List<News>> execute(String query) async {
    return await _newsRepository.getNewsByQuery(query);
  }
}
