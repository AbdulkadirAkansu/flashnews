import 'package:flashnews/bloc/article/article_bloc.dart';
import 'package:flashnews/bloc/splash/splash_bloc.dart';
import 'package:flashnews/bloc/topheadlines/top_bloc.dart';
import 'package:flashnews/screen/splash/splash_screen.dart';
import 'package:flashnews/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ArticleBloc(newsService: NewsService()),
        ),
        BlocProvider(
          create: (context) => TopHeadlinesBloc(newsService: NewsService()),
        ),
        BlocProvider(
          create: (context) => SplashBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'FlashNews',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
