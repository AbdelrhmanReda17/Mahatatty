import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/news_model.dart';

abstract class BaseNewsRemoteDataSource {
  Future<List<NewsModel>> getAllNews();

  Future<List<NewsModel>> getLatestNews();

  Future<List<NewsModel>> getNewsByCategory(String category);

  Future<List<NewsModel>> getNewsByQuery(String query);
}

class NewsRemoteDataSource implements BaseNewsRemoteDataSource {
  final FirebaseFirestore firestore;

  NewsRemoteDataSource(this.firestore);

  Future<List<NewsModel>> getAllNews() async {
    try {
      await Future.delayed(Duration(seconds: 4));
      QuerySnapshot snapshot = await firestore.collection('news').get();
      List<NewsModel> newsList = snapshot.docs.map((doc) {
        return NewsModel.fromFireStore(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      return newsList;
    } catch (e) {
      log('Error: $e');
      throw Exception('Error fetching news: $e');
    }
  }

  Future<List<NewsModel>> getLatestNews() async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection('news')
          .orderBy('publishedAt', descending: true)
          .limit(5)
          .get();
      List<NewsModel> newsList = snapshot.docs.map((doc) {
        return NewsModel.fromFireStore(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      return newsList;
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }

  Future<List<NewsModel>> getNewsByCategory(String category) async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection('news')
          .where('category', isEqualTo: category)
          .get();
      List<NewsModel> newsList = snapshot.docs.map((doc) {
        return NewsModel.fromFireStore(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      return newsList;
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }

  Future<List<NewsModel>> getNewsByQuery(String query) async {
    try {
      QuerySnapshot snapshot = await firestore.collection('news').get();
      List<NewsModel> newsList = snapshot.docs
          .map((doc) => NewsModel.fromFireStore(
              doc.data() as Map<String, dynamic>, doc.id))
          .where(
              (news) => news.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
      return newsList;
    } catch (e) {
      log('Error: $e');
      throw Exception('Error fetching news: $e');
    }
  }
}
