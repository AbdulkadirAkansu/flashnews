import 'package:flashnews/bloc/topheadlines/top_bloc.dart';
import 'package:flashnews/bloc/topheadlines/top_event_bloc.dart';
import 'package:flashnews/bloc/topheadlines/top_state_bloc.dart';
import 'package:flashnews/screen/topheadlines/widgets/article_card.dart';
import 'package:flashnews/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class ArticlesBySourceScreen extends StatelessWidget {
  final String sourceId;
  final String sourceName;

  const ArticlesBySourceScreen({super.key, required this.sourceId, required this.sourceName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        color: Colors.white,
        child: BlocProvider(
          create: (context) => TopHeadlinesBloc(newsService: NewsService())
            ..add(FetchArticlesBySource(sourceId)),
          child: BlocBuilder<TopHeadlinesBloc, TopHeadlinesState>(
            builder: (context, state) {
              if (state is ArticlesBySourceLoading) {
                return _buildLoading();
              } else if (state is ArticlesBySourceLoaded) {
                return _buildArticleList(context, state);
              } else if (state is TopHeadlinesError) {
                return _buildError(state);
              }
              return _buildFallback();
            },
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        sourceName,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildArticleList(BuildContext context, ArticlesBySourceLoaded state) {
    if (state.articles.isEmpty) {
      return const Center(child: Text('No articles found'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: state.articles.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            top: index == 0 ? 16.0 : 8.0,
            bottom: 8.0,
          ),
          child: ArticleCard(article: state.articles[index]),
        );
      },
    );
  }

  Widget _buildError(TopHeadlinesError state) {
    return Center(child: Text(state.message));
  }

  Widget _buildFallback() {
    return const Center(child: Text('Please try again later'));
  }
}
