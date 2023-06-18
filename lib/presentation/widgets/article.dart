import 'package:flutter/material.dart';
import 'package:rse/data/models/all.dart' as models;
import 'package:rse/presentation/utils/all.dart';

class Article extends StatefulWidget {
  final models.Article article;

  const Article({Key? key, required this.article}) : super(key: key);

  @override
  ArticleState createState() => ArticleState();
}

class ArticleState extends State<Article> {
  late String imageUrl;

  @override
  void initState() {
    super.initState();
    imageUrl = widget.article.urlToImage ?? "https://awlights.com/wp-content/uploads/sites/31/2017/05/placeholder-news.jpg";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isWeb && isMed(context)
          ? const EdgeInsets.all(50)
          : const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: isWeb && isMed(context)
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildArticleContent(context),
            ),
          ),
          const SizedBox(width: 50),
          Flexible(
            flex: 1,
            child: _buildArticleImage(context),
          ),
        ],
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildArticleImage(context),
          const SizedBox(height: 20),
          ..._buildArticleContent(context),
        ],
      ),
    );
  }

  List<Widget> _buildArticleContent(BuildContext context) {
    return [
      Text(
        widget.article.title ?? '',
        style: TextStyle(
          fontSize: isWeb && isMed(context) ? 30 : 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        widget.article.author ?? '',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        widget.article.source.id ?? '',
        style: const TextStyle(
          fontSize: 18,
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        widget.article.description ?? '',
        style: const TextStyle(fontSize: 14),
      ),
      const SizedBox(height: 4),
      Text(
        'Published on: ${widget.article.publishedAt?.toString() ?? ''}',
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      const SizedBox(height: 4),
      Text(
        widget.article.url?.toString() ?? '',
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      const SizedBox(height: 8),
    ];
  }

  Widget _buildArticleImage(BuildContext context) {
    double imageWidth = MediaQuery.of(context).size.width / 3;

    if (isSmall(context)) {
      imageWidth = MediaQuery.of(context).size.width;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: imageWidth,
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            onError: (_, __) {
              setState(() {
                imageUrl = "https://awlights.com/wp-content/uploads/sites/31/2017/05/placeholder-news.jpg";
              });
            },
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }

}
