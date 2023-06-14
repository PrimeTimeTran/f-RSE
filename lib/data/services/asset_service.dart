import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rse/data/models/chart.dart';

import 'package:rse/data/services/all.dart';
import 'package:rse/presentation/utils/constants.dart';

class Asset {
  final String? name;
  final String? symbol;
  final List<CandleStick> live;
  Asset({
    required this.name,
    required this.symbol,
    required this.live,
  });
  factory Asset.fromJson(Map<String, dynamic> j) {
    return Asset(
      name: j['name'],
      symbol: j['symbol'],
      live: [
        for (var cs in jsonDecode(j['live'])['series']) CandleStick.fromJson(cs)
      ],
    );
  }
  factory Asset.defaultPortfolio() => Asset(
    name: '',
    live: [],
    symbol: '',
  );
}

class AssetService {
  final LocalStorageService _localStorage = LocalStorageService();

  Future<Asset> fetchAsset(String id) async {
    try {
      // if (kDebugMode) throw Error();
      final response = await http.get(Uri.parse("$api/assets/$id?period=live"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final d = Asset.fromJson(data);
        _localStorage.saveData('assets/$id', response.body);
        return d;
      } else {
        throw Error();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: Fetching asset. Loading from cache $e');
      }
      // return await _localStorage.getCachedAsset();
    }

    return Asset.defaultPortfolio();
  }
}
