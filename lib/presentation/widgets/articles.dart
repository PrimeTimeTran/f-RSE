import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/all.dart';

class Articles extends StatelessWidget {
  const Articles({
    super.key,
  });

  getWidth(context) {
    var width = MediaQuery.of(context).size.width;
    if (isS(context)) {
      return width;
    } else if (isM(context)) {
      return width * .9;
    } else {
      return width * .6;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getWidth(context),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Trending News",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          BlocBuilder<NewsCubit, List<NewsArticle>>(
            builder: (context, articles) {
              if (articles.isEmpty) {
                return const CircularProgressIndicator();
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: articles.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Article(article: articles[index]);
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
