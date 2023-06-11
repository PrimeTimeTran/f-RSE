import 'dart:convert';

import 'package:rse/data/models/all.dart';

class Portfolio {
  final Current current;
  final List<Stock> stocks;
  final List<Crypto> cryptos;
  final List<CandleStick> series;

  Portfolio({
    required this.stocks,
    required this.series,
    required this.current,
    required this.cryptos,
  });

  factory Portfolio.fromJson(Map<String, dynamic> json) {
    final v = jsonDecode(json['valuation']);
    return Portfolio(
      current: Current.fromJson(v['current']),
      stocks: [
        for (var s in v['stocks']['items']) Stock.fromJson(s)
      ],
      cryptos: [
        for (var c in v['cryptocurrencies']['items']) Crypto.fromJson(c)
      ],
      series: [
        for (var cs in v['timeSeries']) CandleStick.fromJson(cs)
      ],
    );
  }
  factory Portfolio.defaultPortfolio() => Portfolio(
    stocks: [],
    series: [],
    cryptos: [],
    current: Current(
      totalValue: 0.0,
      cryptocurrencies: Cryptocurrencies(
        value: 0.0,
        percentage: 0.0,
      ),
      stocksAndOptions: StocksAndOptions(
        value: 0.0,
        percentage: 0.0,
      ),
    ),
  );
}

class Current {
  final double totalValue;
  final StocksAndOptions stocksAndOptions;
  final Cryptocurrencies cryptocurrencies;

  Current({
    required this.totalValue,
    required this.stocksAndOptions,
    required this.cryptocurrencies,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
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
