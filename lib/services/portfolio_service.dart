import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:rse/data/models/portfolio.dart';
import 'package:rse/common/utils/constants.dart';

class PortfolioService {
  Future<Portfolio> fetchPortfolio(String id) async {
    try {
      final response = await http.get(Uri.parse("$api/portfolios/$id"));
      final d = Portfolio.fromJson(json.decode(response.body));
      return d;
    } catch (e) {
      print('Error fetching portfolio');
    }
    return Portfolio.defaultPortfolio();
  }
}
