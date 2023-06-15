import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/cubits/all.dart';
import 'package:rse/data/models/all.dart' as models;
import 'package:rse/presentation/utils/constants.dart';
import 'package:rse/presentation/widgets/all.dart';

class Articles extends StatelessWidget {
  const Articles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * (isWeb ? 0.60 : .95),
      child: Column(
        children: [
          Container(
            margin: isWeb
                ? const EdgeInsets.only(top: 20.0, bottom: 10.0, left: 10.0)
                : const EdgeInsets.only(top: 0, bottom: 0),
            child: const Align(
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
          // const NewsList(),
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
