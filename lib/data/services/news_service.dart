import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import 'package:rse/data/models/all.dart';
import 'package:rse/data/services/all.dart';
import 'package:rse/presentation/utils/all.dart';

class NewsService {
  final LocalStorageService _localStorage = LocalStorageService();

  Future<List<Article>> fetchArticles() async {
    try {
      if (kDebugMode) throw Error();
      final response = await http.get(Uri.parse(newsApi));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        _localStorage.saveData('articles', response.body);
        final List<dynamic> articles = data['results'] as List<dynamic>;
        debugPrint("Articles from API");
        return articles.map((item) => Article.fromJson(item)).toList();
      } else {
        throw Error();
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Error: Fetching articles, loading from cache.");
      }
      return await _localStorage.getCachedArticles();
    }
  }
}
