import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'package:rse/data/all.dart';

class NewsCubit extends Cubit<List<NewsArticle>> {
  final NewsService _newsService = NewsService();

  NewsCubit() : super([]);

  Future<void> fetchArticles() async {
    try {
      final articles = await _newsService.fetchArticles();
      emit(articles);
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching articles: $error');
      }
    }
  }
}
