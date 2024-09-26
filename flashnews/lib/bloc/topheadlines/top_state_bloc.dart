import 'package:equatable/equatable.dart';
import 'package:flashnews/models/article.dart';
import 'package:flashnews/models/sources.dart';



abstract class TopHeadlinesState extends Equatable {
  const TopHeadlinesState();

  @override
  List<Object> get props => [];
}

class TopHeadlinesInitial extends TopHeadlinesState {}

class TopHeadlinesLoading extends TopHeadlinesState {}

class TopHeadlinesLoaded extends TopHeadlinesState {
  final List<Sources> sources;

  const TopHeadlinesLoaded(this.sources);

  @override
  List<Object> get props => [sources];
}

class TopHeadlinesError extends TopHeadlinesState {
  final String message;

  const TopHeadlinesError(this.message);

  @override
  List<Object> get props => [message];
}

class ArticlesBySourceLoading extends TopHeadlinesState {}

class ArticlesBySourceLoaded extends TopHeadlinesState {
  final List<Articles> articles;

  const ArticlesBySourceLoaded(this.articles);

  @override
  List<Object> get props => [articles];
}

class ArticlesBySourceError extends TopHeadlinesState {
  final String message;

  const ArticlesBySourceError(this.message);

  @override
  List<Object> get props => [message];
}
