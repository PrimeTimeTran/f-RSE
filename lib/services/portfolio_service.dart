import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:rse/data/models/candlestick_data.dart';

import 'package:rse/common/utils/constants.dart';

class PortfolioService {
  Future<List<CandleStickData>?> fetchValues() async {
    try {
      final response = await http.get(Uri.parse("$API/prices"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;
        final stockData = data.map((d) => CandleStickData.fromJson(d)).toList();
        return stockData;
      } else {
        print('Failure fetching portfolio');
      }
    } catch (e) {
      print('Error fetching portfolio');
    }
    return null;
  }
}
