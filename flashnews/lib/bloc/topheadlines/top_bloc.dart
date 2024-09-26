import 'package:flashnews/bloc/topheadlines/top_event_bloc.dart';
import 'package:flashnews/bloc/topheadlines/top_state_bloc.dart';
import 'package:flashnews/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class TopHeadlinesBloc extends Bloc<TopHeadlinesEvent, TopHeadlinesState> {
  final NewsService newsService;

  TopHeadlinesBloc({required this.newsService}) : super(TopHeadlinesInitial()) {
    on<FetchTopHeadlinesSources>(_onFetchTopHeadlinesSources);
    on<FetchArticlesBySource>(_onFetchArticlesBySource);
    on<SearchTopHeadlinesSources>(_onSearchTopHeadlinesSources);
  }

  void _onFetchTopHeadlinesSources(FetchTopHeadlinesSources event, Emitter<TopHeadlinesState> emit) async {
    emit(TopHeadlinesLoading());
    try {
      final response = await newsService.fetchTopHeadlinesSources();
      emit(TopHeadlinesLoaded(response.sources ?? []));
    } catch (e) {
      emit(TopHeadlinesError(e.toString()));
    }
  }

  void _onFetchArticlesBySource(FetchArticlesBySource event, Emitter<TopHeadlinesState> emit) async {
    emit(ArticlesBySourceLoading());
    try {
      final response = await newsService.fetchArticlesBySource(event.sourceId);
      emit(ArticlesBySourceLoaded(response.articles ?? []));
    } catch (e) {
      emit(ArticlesBySourceError(e.toString()));
    }
  }

  void _onSearchTopHeadlinesSources(SearchTopHeadlinesSources event, Emitter<TopHeadlinesState> emit) {
    if (state is TopHeadlinesLoaded) {
      final currentState = state as TopHeadlinesLoaded;
      if (event.query.isEmpty) {
        // Fetch all sources if the search query is empty
        add(FetchTopHeadlinesSources());
      } else {
        final filteredSources = currentState.sources.where((source) {
          return source.name!.toLowerCase().contains(event.query.toLowerCase());
        }).toList();
        emit(TopHeadlinesLoaded(filteredSources));
      }
    }
  }
}
