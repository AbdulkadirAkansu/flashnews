import 'package:flashnews/models/article.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Articles article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    String formattedDate = _formatDate(article.publishedAt);
    String content = _formatContent(article.content);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: article.urlToImage ?? '',
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey,
              child: const Center(
                child: Icon(Icons.image, color: Colors.white, size: 100),
              ),
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.45,
            fit: BoxFit.cover,
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.55,
            minChildSize: 0.55,
            maxChildSize: 1.0,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(30.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 50,
                          height: 5,
                          margin: const EdgeInsets.only(bottom: 12.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      Text(
                        article.title ?? 'No Title',
                        style: GoogleFonts.poppins(
                            fontSize: 26.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12.0),
                      Row(
                        children: [
                          if (article.author != null) ...[
                            const Icon(Icons.person, size: 18.0),
                            const SizedBox(width: 4.0),
                            Expanded(
                              child: Text(
                                article.author!,
                                style: GoogleFonts.poppins(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                          const SizedBox(width: 16.0),
                          const Icon(Icons.access_time, size: 18.0),
                          const SizedBox(width: 4.0),
                          Text(
                            formattedDate,
                            style: GoogleFonts.poppins(
                                fontSize: 14.0, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                      if (article.description != null &&
                          article.description!.isNotEmpty)
                        Text(
                          article.description!,
                          style: GoogleFonts.poppins(fontSize: 16.0),
                        ),
                      const SizedBox(height: 12.0),
                      Text(
                        content,
                        style: GoogleFonts.poppins(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _formatDate(String? date) {
    return date != null
        ? DateFormat('yyyy-MM-dd').format(DateTime.parse(date))
        : 'Unknown Date';
  }

  String _formatContent(String? content) {
    const int maxLength = 200;
    if (content != null && content.length > maxLength) {
      return '${content.substring(0, maxLength)}...';
    }
    return content ?? 'No Content';
  }
}
