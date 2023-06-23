import 'package:flutter/material.dart';

import 'package:rse/presentation/utils/all.dart';
import 'package:rse/data/models/all.dart' as models;
import 'package:rse/presentation/widgets/all.dart';

const placeholder = "https://awlights.com/wp-content/uploads/sites/31/2017/05/placeholder-news.jpg";

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
    imageUrl = widget.article.urlToImage ?? placeholder;
  }

  getPadding(context) {
    if (isS(context)) {
      return 20;
    } else if (isM(context)) {
      return 20;
    }
    return 50;
  }

  @override
  Widget build(BuildContext context) {
    return HoverDarken(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: getPadding(context), horizontal: getPadding(context)),
          child: isS(context) ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildArticleImage(context),
                  const SizedBox(height: 20),
                  ..._buildArticleContent(context),
                ],
            )
          : Row(
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
      ),
    );
  }

  List<Widget> _buildArticleContent(BuildContext context) {
    return [
      Text(
        widget.article.title ?? '',
        style: TextStyle(
          fontSize: isWeb && isM(context) ? 18 : 15,
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

    if (isS(context)) {
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
                imageUrl = placeholder;
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
