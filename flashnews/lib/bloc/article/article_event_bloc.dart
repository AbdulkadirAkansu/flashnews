import 'package:equatable/equatable.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

class FetchLatestNews extends ArticleEvent {
  final String country;

  const FetchLatestNews(this.country);

  @override
  List<Object> get props => [country];
}

class RefreshArticles extends ArticleEvent {
  final String country;

  const RefreshArticles(this.country);

  @override
  List<Object> get props => [country];
}
