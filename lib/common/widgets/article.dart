import 'package:flutter/material.dart';

import 'package:rse/data/models/all.dart';

class ArticleWidget extends StatelessWidget {
  final Article article;

  const ArticleWidget({required this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (article.urlToImage != null)
            Image.network(
              article.urlToImage!,
              fit: BoxFit.cover,
              height: 200,
            ),
          const SizedBox(height: 8),
          Text(
            article.title ?? '',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            article.description ?? '',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            'Published on: ${article.publishedAt?.toString() ?? ''}',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
