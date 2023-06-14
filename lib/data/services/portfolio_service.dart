import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:rse/data/services/all.dart';
import 'package:rse/data/models/portfolio.dart';
import 'package:rse/presentation/utils/constants.dart';

class PortfolioService {
  final LocalStorageService _localStorage = LocalStorageService();

  Future<Portfolio> fetchPortfolio(String id) async {
    try {
      // if (kDebugMode) throw Error();
      final response = await http.get(Uri.parse("$api/portfolios/$id"));
      if (response.statusCode == 200) {
        final d = Portfolio.fromJson(json.decode(response.body));
        _localStorage.saveData('portfolio', response.body);
        return d;
      } else {
        throw Error();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: Fetching portfolios. Loading from cache');
      }
      return await _localStorage.getCachedPortfolio();
    }
  }
}
