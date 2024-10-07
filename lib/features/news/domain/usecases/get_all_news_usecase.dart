import '../entities/news.dart';
import '../repository/news_repository.dart';

class GetAllNewsUseCase {
  final BaseNewsRepository _newsRepository;

  GetAllNewsUseCase(this._newsRepository);

  Future<List<News>> execute() async {
    return await _newsRepository.getAllNews();
  }
}
