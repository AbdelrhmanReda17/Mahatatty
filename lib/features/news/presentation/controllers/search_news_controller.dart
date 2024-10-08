import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewsSearchState {
  String query;

  NewsSearchState({
    this.query = '',
  });

  NewsSearchState copyWith({
    String? query,
  }) {
    return NewsSearchState(
      query: query ?? this.query,
    );
  }

  @override
  String toString() {
    return 'SearchState(query: $query)';
  }
}

final newsSearchProvider = StateProvider<NewsSearchState>((ref) {
  return NewsSearchState();
});
