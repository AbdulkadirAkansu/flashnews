import 'package:equatable/equatable.dart';

abstract class TopHeadlinesEvent extends Equatable {
  const TopHeadlinesEvent();

  @override
  List<Object> get props => [];
}

class FetchTopHeadlinesSources extends TopHeadlinesEvent {}

class FetchArticlesBySource extends TopHeadlinesEvent {
  final String sourceId;

  const FetchArticlesBySource(this.sourceId);

  @override
  List<Object> get props => [sourceId];
}

class SearchTopHeadlinesSources extends TopHeadlinesEvent {
  final String query;

  const SearchTopHeadlinesSources(this.query);

  @override
  List<Object> get props => [query];
}
