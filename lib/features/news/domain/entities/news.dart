import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  final String id;
  final String title;
  final String description;
  final String urlToImage;
  final Timestamp publishedAt;
  final int upVote;
  final int downVote;
  final String author;

  News({
    required this.id,
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.publishedAt,
    this.upVote = 0,
    this.downVote = 0,
    required this.author,
  });

  @override
  String toString() {
    return 'news(title: $title, description: $description, urlToImage: $urlToImage, publishedAt: $publishedAt, upVote: $upVote, downVote: $downVote, author: $author)';
  }
}
