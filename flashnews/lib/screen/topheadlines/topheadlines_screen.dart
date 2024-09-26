import 'package:flashnews/bloc/topheadlines/top_bloc.dart';
import 'package:flashnews/bloc/topheadlines/top_event_bloc.dart';
import 'package:flashnews/screen/topheadlines/topheadlines_view.dart';
import 'package:flashnews/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TopHeadlinesScreen extends StatelessWidget {
  const TopHeadlinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocProvider(
        create: (context) => TopHeadlinesBloc(newsService: NewsService())
          ..add(FetchTopHeadlinesSources()),
        child: TopHeadlinesView(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Top Headlines',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
