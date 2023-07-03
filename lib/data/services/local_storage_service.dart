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

  Future<List<NewsArticle>> getCachedArticles() async {
    var data = await loadData('articles');

    if (data != null && data.isNotEmpty) {
      return _mapArticlesFromData(jsonDecode(data)['results']);
    } else {
      final d = await loadJsonFile('assets/news.json');
      if (d != null && d.isNotEmpty) {
        return _mapArticlesFromData(d['results']);
      }
    }
    debugPrint('Error: Error loading cached articles');
    return [];
  }

  List<NewsArticle> _mapArticlesFromData(dynamic data) {
    return (data as List<dynamic>)
      .map((item) => NewsArticle.fromJson(item as Map<String, dynamic>))
      .toList();
  }

  Future<Portfolio> getCachedPortfolio(period) async {
    var data = await loadData('portfolio-$period');
    if (data != null && data.isNotEmpty) {
      return Portfolio.fromJson(jsonDecode(data), period: period);
    } else {
      final path = 'assets/portfolio-$period.json';
      final d = await loadJsonFile(path);
      if (d != null && d.isNotEmpty) {
        return Portfolio.fromJson(d, period: period);
      }
    }
    return Portfolio.defaultPortfolio();
  }

  Future<Asset> getCachedAsset(String symbol, period) async {
    symbol = symbol.toLowerCase();
    var data = await loadData('$symbol-$period');
    if (data != null && data.isNotEmpty) {
      return Asset.fromJson(jsonDecode(data), period);
    } else {
      final d = await loadJsonFile('assets/$symbol-$period.json');
      if (d != null && d.isNotEmpty) {
        return Asset.fromJson(d as Map<String, dynamic>, period);
      }
    }
    return Asset.defaultAsset();
  }
}
