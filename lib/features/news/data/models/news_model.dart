import '../../domain/entities/news.dart';

class NewsModel extends News {
  NewsModel({
    required super.id,
    required super.title,
    required super.description,
    required super.urlToImage,
    required super.publishedAt,
    required super.author,
    super.upVote,
    super.downVote,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      author: json['author'],
      upVote: json['upVote'] ?? 0,
      downVote: json['downVote'] ?? 0,
    );
  }

  factory NewsModel.fromFireStore(
      Map<String, dynamic> data, String documentId) {
    return NewsModel(
      id: documentId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      urlToImage: data['urlToImage'] ?? '',
      publishedAt: data['publishedAt'] ?? '',
      upVote: data['upVote'] ?? 0,
      downVote: data['downVote'] ?? 0,
      author: data['author'] ?? 'Unknown',
    );
  }
}
