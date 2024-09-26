import 'package:flashnews/models/article.dart';
import 'package:flashnews/screen/detail/article_detail_screen.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';


class ArticleList extends StatelessWidget {
  final List<Articles> articles;

  const ArticleList({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleDetailScreen(
                    article: articles[index],
                  ),
                ),
              );
            },
            child: _buildArticleCard(context, articles[index]),
          ),
        );
      },
    );
  }

  Widget _buildArticleCard(BuildContext context, Articles article) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(article),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              article.title ?? 'No Title',
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              article.description ?? 'No Description',
              style: GoogleFonts.poppins(
                  fontSize: 14, color: Colors.grey[700]),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }

  Widget _buildImage(Articles article) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(15.0),
      ),
      child: article.urlToImage != null
          ? CachedNetworkImage(
              imageUrl: article.urlToImage!,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey,
                child: const Icon(Icons.image,
                    color: Colors.white, size: 100),
              ),
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            )
          : Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey,
              child: const Icon(Icons.image,
                  color: Colors.white, size: 100),
            ),
    );
  }
}
