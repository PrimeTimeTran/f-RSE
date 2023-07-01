import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:rse/all.dart';

class PortfolioService {
  final LocalStorageService _localStorage = LocalStorageService();

  Future<Portfolio> fetchPortfolio(int id, String period) async {
    try {
      var path = Uri.parse("$api/portfolios/$id?period=$period");
      final response = await http.get(path);
      if (response.statusCode == 200) {
        final p = Portfolio.fromJson(json.decode(response.body), period: period);
        _localStorage.saveData('portfolio', response.body);
        return p;
      } else {
        throw Error();
      }
    } catch (e) {
      p("Error: Fetching portfolio. Loading from cache.");
      return await _localStorage.getCachedPortfolio(period);
    }
  }
}
