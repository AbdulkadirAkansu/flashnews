import 'dart:convert';
import 'package:flashnews/models/news.dart';
import 'package:flashnews/models/topheadlines.dart';
import 'package:http/http.dart' as http;

class NewsService {
  final String apiKey = 'c0e0428bfeeb43159e94f58c4ba69ef4';

  Future<News> fetchLatestNews({required String country}) async {
    try {
      final response = await http.get(
        Uri.parse(
            "https://newsapi.org/v2/top-headlines?country=$country&apiKey=$apiKey"),
      );

      if (response.statusCode == 200) {
        return News.fromJson(json.decode(response.body));
      } else {
        throw Exception(
            'Failed to load articles: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to load articles: $e');
    }
  }

  Future<Topheadlines> fetchTopHeadlinesSources() async {
    final response = await http.get(
      Uri.parse("https://newsapi.org/v2/top-headlines/sources?apiKey=$apiKey"),
    );

    if (response.statusCode == 200) {
      return Topheadlines.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines sources');
    }
  }

  Future<News> fetchArticlesBySource(String sourceId) async {
    final response = await http.get(
      Uri.parse(
          "https://newsapi.org/v2/top-headlines?sources=$sourceId&apiKey=$apiKey"),
    );

    if (response.statusCode == 200) {
      return News.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load articles by source');
    }
  }
}
