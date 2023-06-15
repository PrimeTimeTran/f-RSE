import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rse/data/models/chart.dart';

import 'package:rse/data/services/all.dart';
import 'package:rse/presentation/utils/constants.dart';

class Asset {
  final String? name;
  final String? symbol;
  final List<CandleStick> current;
  Asset({
    required this.name,
    required this.symbol,
    required this.current,
  });
  factory Asset.fromJson(Map<String, dynamic> j, String period) {
    Map<String, dynamic> mapping = {
      "live": "live",
      "1d": "oneDay",
      "1w": "oneWeek",
      "1m": "oneMonth",
      "3m": "threeMonths",
      "ytd": "yearToDate",
      "1y": "oneYear",
      "all": "allData",
    };
    return Asset(
      name: j['name'],
      symbol: j['symbol'],
      current: [
        for (var cs in jsonDecode(j[mapping[period]])['series']) CandleStick.fromJson(cs)
      ],
    );
  }
  factory Asset.defaultPortfolio() => Asset(
    name: '',
    current: [],
    symbol: '',
  );
}

class AssetService {
  final LocalStorageService _localStorage = LocalStorageService();

  Future<Asset> fetchAsset(String id, String period) async {
    try {
      // if (kDebugMode) throw Error();
      final response = await http.get(Uri.parse("$api/assets/$id?period=$period"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final d = Asset.fromJson(data, period);

        _localStorage.saveData('assets/$id', response.body);
        return d;
      } else {
        throw Error();
      }
    } catch (e) {
      debugPrint("Error: Portfolio Asset. Loading from cache");
      // return await _localStorage.getCachedAsset();
    }

    return Asset.defaultPortfolio();
  }
}
