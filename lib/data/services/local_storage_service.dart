import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rse/data/all.dart';
import 'package:rse/presentation/utils/all.dart';

class LocalStorageService {
  Future<void> saveData(String key, String value,
      {bool overwrite = true}) async {
    final prefs = await SharedPreferences.getInstance();
    if (overwrite || !prefs.containsKey(key)) {
      await prefs.setString(key, value);
    }
  }

  Future<String?> loadData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<List<Article>> getCachedArticles() async {
    var data = await loadData('articles');

    if (data != null && data.isNotEmpty) {
      return _mapArticlesFromData(jsonDecode(data)['results']);
    } else {
      final d = await loadJsonFile('news.json');
      if (d != null && d.isNotEmpty) {
        return _mapArticlesFromData(d['results']);
      }
    }
    debugPrint('Error: Error loading cached articles');
    return [];
  }

  List<Article> _mapArticlesFromData(dynamic data) {
    return (data as List<dynamic>)
      .map((item) => Article.fromJson(item as Map<String, dynamic>))
      .toList();
  }

  Future<Portfolio> getCachedPortfolio() async {
    var data = await loadData('portfolio');
    if (data != null && data.isNotEmpty) {
      return Portfolio.fromJson(data as Map<String, dynamic>);
    } else {
      final d = await loadJsonFile('portfolio.json');
      if (d != null && d.isNotEmpty) {
        return Portfolio.fromJson(d);
      }
    }
    return Portfolio.defaultPortfolio();
  }

  Future<Asset> getCachedAsset(String symbol, period) async {
    var data = await loadData('$symbol-$period');
    if (data != null && data.isNotEmpty) {
      return Asset.fromJson(data as Map<String, dynamic>, period);
    } else {
      final d = await loadJsonFile('$symbol-$period.json');
      if (d != null && d.isNotEmpty) {
        return Asset.fromJson(d as Map<String, dynamic>, period);
      }
    }
    return Asset.defaultAsset();
  }
}
