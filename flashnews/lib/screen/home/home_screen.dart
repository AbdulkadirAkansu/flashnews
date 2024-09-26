import 'package:flashnews/bloc/article/article_bloc.dart';
import 'package:flashnews/bloc/article/article_event_bloc.dart';
import 'package:flashnews/bloc/article/article_state_bloc.dart';
import 'package:flashnews/screen/home/widgets/article_list.dart';
import 'package:flashnews/screen/home/widgets/custom_appbar.dart';
import 'package:flashnews/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocProvider(
        create: (context) => ArticleBloc(newsService: NewsService())
          ..add(const FetchLatestNews('us')),
        child: BlocBuilder<ArticleBloc, ArticleState>(
          builder: (context, state) {
            if (state is ArticleLoading) {
              return _buildLoading();
            } else if (state is ArticleLoaded) {
              return _buildArticleList(context, state);
            } else if (state is ArticleError) {
              return _buildError(state);
            }
            return _buildFallback();
          },
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildArticleList(BuildContext context, ArticleLoaded state) {
    if (state.articles.isEmpty) {
      return const Center(child: Text('No articles found'));
    }
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ArticleBloc>().add(const RefreshArticles('us'));
      },
      child: ArticleList(articles: state.articles),
    );
  }

  Widget _buildError(ArticleError state) {
    return Center(child: Text(state.message));
  }

  Widget _buildFallback() {
    return const Center(child: Text('Please try again later'));
  }
}
