import 'package:flashnews/bloc/topheadlines/top_bloc.dart';
import 'package:flashnews/bloc/topheadlines/top_event_bloc.dart';
import 'package:flashnews/bloc/topheadlines/top_state_bloc.dart';
import 'package:flashnews/screen/topheadlines/source_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TopHeadlinesView extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  TopHeadlinesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildSearchField(context),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search sources...',
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15.0),
          ),
          onChanged: (value) {
            BlocProvider.of<TopHeadlinesBloc>(context)
                .add(SearchTopHeadlinesSources(value));
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Expanded(
      child: BlocBuilder<TopHeadlinesBloc, TopHeadlinesState>(
        builder: (context, state) {
          if (state is TopHeadlinesLoading) {
            return _buildLoading();
          } else if (state is TopHeadlinesLoaded) {
            return SourceList(sources: state.sources);
          } else if (state is TopHeadlinesError) {
            return _buildError(state);
          }
          return _buildFallback();
        },
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildError(TopHeadlinesError state) {
    return Center(
      child: Text(
        state.message,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildFallback() {
    return const Center(
      child: Text(
        'Please try again later',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
