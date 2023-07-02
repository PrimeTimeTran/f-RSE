import 'dart:convert';

import 'package:rse/all.dart';

class Portfolio {
  final int id;
  String period;
  List<Stock>? stocks;
  List<Crypto>? cryptos;
  List<DataPoint> series;
  PortMeta? meta = PortMeta(
    stocksAndOptions: StocksAndOptions(
      value: 0.0,
      percentage: 0.0,
    ),
    cryptocurrencies: Cryptocurrencies(
      value: 0.0,
      percentage: 0.0,
    ),
  );

  Portfolio({
    this.meta,
    this.stocks,
    this.cryptos,
    required this.id,
    required this.series,
    required this.period,
  });

  factory Portfolio.fromJson(Map<String, dynamic> json, {String period = 'live' }) {
    // Allow portfolios to have valuations included & not.
    // The initial live portfolio load will have it included whilst the subsequent
    // period selections won't. In this way we improve performance of server calculations & reduce json for Android.
    final v = json['valuation'] != null ? jsonDecode(json['valuation']) : null;
    return Portfolio(
      id: 1,
      period: 'live',
      meta: v != null ? PortMeta.fromJson(v['current']) : null,
      stocks: v?['stocks'] != null
          ? [for (var s in v['stocks']['items']) Stock.fromJson(s)]
          : null,
      cryptos: v?['cryptocurrencies'] != null
          ? [for (var c in v['cryptocurrencies']['items']) Crypto.fromJson(c)]
          : null,
      series: [
        for (var cs in jsonDecode(json[periodMapping[period]]) ) DataPoint(cs['time'], cs['value'])
      ],
    );
  }

  factory Portfolio.defaultPortfolio() => Portfolio(
    id: 1,
    series: [],
    stocks: [],
    cryptos: [],
    period: 'live',
    meta: PortMeta(
      stocksAndOptions: StocksAndOptions(
        value: 0.0,
        percentage: 0.0,
      ),
      cryptocurrencies: Cryptocurrencies(
        value: 0.0,
        percentage: 0.0,
      ),
    ),
  );

  Portfolio copyWith({
    int? id,
    PortMeta? meta,
    String? period,
    List<Stock>? stocks,
    List<Crypto>? cryptos,
    List<DataPoint>? series,
  }) {
    return Portfolio(
      id: id ?? this.id,
      meta: meta ?? this.meta,
      period: period ?? this.period,
      stocks: stocks ?? this.stocks,
      series: series ?? this.series,
      cryptos: cryptos ?? this.cryptos,
    );
  }

  setSeries(v) {
    series = [for (var cs in v['series']) DataPoint(cs['time'], cs['value'])];
  }
}

class PortMeta {
  double totalValue;
  StocksAndOptions stocksAndOptions;
  Cryptocurrencies cryptocurrencies;

  PortMeta({
    this.totalValue = 0,
    required this.stocksAndOptions,
    required this.cryptocurrencies,
  });

  factory PortMeta.fromJson(Map<String, dynamic> json) {
    return PortMeta(
      totalValue: json['totalValue'],
      stocksAndOptions: StocksAndOptions.fromJson(json['stocks_and_options']),
      cryptocurrencies: Cryptocurrencies.fromJson(json['cryptocurrencies']),
    );
  }
}

class Investment {
  final int idx;
  final String name;
  final double value;
  final double quantity;
  final double totalValue;
  final double percentage;

  Investment({
    required this.idx,
    required this.name,
    required this.value,
    required this.quantity,
    required this.percentage,
    required this.totalValue,
  });

  double getValue(String key) {
    final Map<String, double> properties = {
      'value': value,
      'quantity': quantity,
      'percentage': percentage,
      'totalValue': totalValue,
    };
    return properties[key] ?? 0.0;
  }

  int compareTo(Investment other, String sortByProperty) {
    switch (sortByProperty) {
      case 'name':
        return name.compareTo(other.name);
      case 'quantity':
        return quantity.compareTo(other.quantity);
      case 'value':
        return value.compareTo(other.value);
      case 'percentage':
        return percentage.compareTo(other.percentage);
      case 'totalValue':
        return totalValue.compareTo(other.totalValue);
      default:
        throw ArgumentError('Invalid property name: $sortByProperty');
    }
  }

  factory Investment.fromJson(Map<String, dynamic> j) =>
      Investment(idx: j['idx'], name: j['symbol'], value: j['value'], percentage: j['percentage'], quantity: j['quantity'], totalValue: j['totalValue']);
}

class StocksAndOptions {
  final double value;
  final double percentage;

  StocksAndOptions({
    required this.value,
    required this.percentage,
  });

  factory StocksAndOptions.fromJson(Map<String, dynamic> json) {
    return StocksAndOptions(
      value: json['value'],
      percentage: json['percentage'],
    );
  }
}

class Cryptocurrencies {
  final double value;
  final double percentage;

  Cryptocurrencies({
    required this.value,
    required this.percentage,
  });

  factory Cryptocurrencies.fromJson(Map<String, dynamic> json) {
    return Cryptocurrencies(
      value: json['value'],
      percentage: json['percentage'],
    );
  }
}

class Stock {
  final double price;
  final String symbol;
  final double quantity;
  final double totalValue;
  final double percentOfGroup;

  Stock({
    required this.price,
    required this.symbol,
    required this.quantity,
    required this.totalValue,
    required this.percentOfGroup,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      price: json['price'],
      symbol: json['symbol'],
      quantity: json['quantity'],
      totalValue: json['totalValue'],
      percentOfGroup: json['percentOfGroup'],
    );
  }
}

class Crypto {
  final double price;
  final String symbol;
  final double quantity;
  final double totalValue;
  final double percentOfGroup;

  Crypto({
    required this.price,
    required this.symbol,
    required this.quantity,
    required this.totalValue,
    required this.percentOfGroup,
  });

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      price: json['price'],
      symbol: json['symbol'],
      quantity: json['quantity'],
      totalValue: json['totalValue'],
      percentOfGroup: json['percentOfGroup'],
    );
  }
}
