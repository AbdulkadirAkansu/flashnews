import 'package:flashnews/models/article.dart';
import 'package:flashnews/screen/detail/article_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';


class ArticleCard extends StatelessWidget {
  final Articles article;

  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailScreen(article: article),
          ),
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(),
              _buildTitle(),
              _buildDescription(),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return article.urlToImage != null
        ? CachedNetworkImage(
            imageUrl: article.urlToImage!,
            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey,
              child: const Icon(Icons.image, color: Colors.white, size: 100),
            ),
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          )
        : Container(
            width: double.infinity,
            height: 200,
            color: Colors.grey,
            child: const Icon(Icons.image, color: Colors.white, size: 100),
          );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        article.title ?? 'No Title',
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        article.description ?? 'No Description',
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.grey[700],
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
