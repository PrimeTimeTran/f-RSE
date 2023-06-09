import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:rse/data/models/all.dart';
import 'package:rse/presentation/utils/helpers.dart';
import 'package:rse/presentation/utils/constants.dart';

class NewsService {
  Future<List<Article>> fetchArticles() async {
    try {
      final response = await http.get(Uri.parse("$newsApi"));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> articles = data['results'] as List<dynamic>;
        List<Article> articleItems = articles.map((item) => Article.fromJson(item)).toList();
        return articleItems;
      } else {
        printResponse(response);
      }
    } catch (e) {
      print('Error fetching articles: $e');
    }
    return [];
  }

}
