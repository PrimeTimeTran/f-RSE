import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:rse/data/models/portfolio.dart';
import 'package:rse/presentation/utils/constants.dart';

class PortfolioService {
  Future<Portfolio> fetchPortfolio(String id) async {
    try {
      final response = await http.get(Uri.parse("$api/portfolios/$id"));
      final d = Portfolio.fromJson(json.decode(response.body));
      return d;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching portfolio: $e');
      }
    }
    return Portfolio.defaultPortfolio();
  }
}
