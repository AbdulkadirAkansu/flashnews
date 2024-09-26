

import 'package:flashnews/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'article_event_bloc.dart';
import 'article_state_bloc.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final NewsService newsService;

  ArticleBloc({required this.newsService}) : super(ArticleInitial()) {
    on<FetchLatestNews>(_onFetchLatestNews);
    on<RefreshArticles>(_onRefreshArticles);
  }

  void _onFetchLatestNews(
      FetchLatestNews event, Emitter<ArticleState> emit) async {
    emit(ArticleLoading());

    try {
      final response =
          await newsService.fetchLatestNews(country: event.country);
      final validArticles = response.articles
              ?.where((article) =>
                  article.urlToImage != null &&
                  article.title != null &&
                  article.description != null)
              .toList() ??
          [];
      emit(ArticleLoaded(validArticles));
    } catch (e) {
      emit(ArticleError(e.toString()));
    }
  }

  void _onRefreshArticles(
      RefreshArticles event, Emitter<ArticleState> emit) async {
    try {
      final response =
          await newsService.fetchLatestNews(country: event.country);
      final validArticles = response.articles
              ?.where((article) =>
                  article.urlToImage != null &&
                  article.title != null &&
                  article.description != null)
              .toList() ??
          [];
      emit(ArticleLoaded(validArticles));
    } catch (e) {
      emit(ArticleError(e.toString()));
    }
  }
}
