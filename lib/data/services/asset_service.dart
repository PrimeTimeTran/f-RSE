import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:rse/data/all.dart';
import 'package:rse/presentation/utils/constants.dart';

class AssetService {
  final LocalStorageService _localStorage = LocalStorageService();

  Future<Asset> fetchAsset(String sym, String period) async {
    try {
      // if (kDebugMode) throw Error();
      final response = await http.get(Uri.parse("$api/assets/$sym?period=$period"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final d = Asset.fromJson(data, period);
        _localStorage.saveData('$sym-$period', response.body);
        return d;
      } else {
        throw Error();
      }
    } catch (e) {
      debugPrint("Error: Fetching asset. Loading from cache.");
      return await _localStorage.getCachedAsset('GOOGL', period);
    }
  }
}
