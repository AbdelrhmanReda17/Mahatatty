import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/news_model.dart';

abstract class BaseNewsRemoteDataSource {
  Future<List<NewsModel>> getAllNews();
  Future<List<NewsModel>> getLatestNews();
  Future<List<NewsModel>> getNewsByQuery(String query);
}

class NewsRemoteDataSource implements BaseNewsRemoteDataSource {
  final FirebaseFirestore fireStore;

  NewsRemoteDataSource(this.fireStore);

  @override
  Future<List<NewsModel>> getAllNews() async {
    try {
      QuerySnapshot snapshot = await fireStore.collection('news').get().timeout(const Duration(seconds: 5));
      List<NewsModel> newsList = snapshot.docs.map((doc) {
        return NewsModel.fromFireStore(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      return newsList;
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }

  @override
  Future<List<NewsModel>> getLatestNews() async {
    try {
      QuerySnapshot snapshot = await fireStore
          .collection('news')
          .orderBy('publishedAt', descending: true)
          .limit(5)
          .get().timeout(const Duration(seconds: 5));
      List<NewsModel> newsList = snapshot.docs.map((doc) {
        return NewsModel.fromFireStore(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      return newsList;
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }


  @override
  Future<List<NewsModel>> getNewsByQuery(String query) async {
    try {
      QuerySnapshot snapshot = await fireStore.collection('news').get().timeout(const Duration(seconds: 8));
      List<NewsModel> newsList = snapshot.docs
          .map((doc) => NewsModel.fromFireStore(
              doc.data() as Map<String, dynamic>, doc.id))
          .where(
              (news) => news.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
      return newsList;
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }
}
