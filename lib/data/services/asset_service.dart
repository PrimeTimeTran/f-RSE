import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:rse/all.dart';

class AssetService {
  final LocalStorageService _localStorage = LocalStorageService();

  Future<Asset> fetchAsset(String sym, String period) async {
    try {
      // if (kDebugMode) throw Error();
      if (kDebugMode) p('API: $api');
      final String path = "$api/assets/$sym?period=$period";
      final response = await http.get(Uri.parse(path));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final d = Asset.fromJson(data, period);
        _localStorage.saveData('$sym-$period', response.body);
        return d;
      } else {
        throw Error();
      }
    } catch (e) {
      p("Error: Fetching asset. Loading from cache. $e");
      return await _localStorage.getCachedAsset('GOOGL', period);
    }
  }
}
