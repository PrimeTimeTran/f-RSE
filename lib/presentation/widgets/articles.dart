import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/cubits/all.dart';
import 'package:rse/presentation/all.dart';
import 'package:rse/data/models/all.dart' as models;

class Articles extends StatelessWidget {
  const Articles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * (isWeb && isMed(context) ? 0.60 : .99),
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
          BlocBuilder<NewsCubit, List<models.Article>>(
            builder: (context, articles) {
              if (articles.isEmpty) {
                return const CircularProgressIndicator();
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: articles.length,
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
