
class Watch {
  final String sym;
  final int shares;
  final double price;
  final double change;
  final double changePercent;
  final List<String> lists = [];

  Watch({
    required this.sym,
    required this.shares,
    required this.price,
    required this.change,
    required this.changePercent,
  });
}

List<Watch> watched = [
  Watch(sym: 'BAC', shares: 200, price: 30.00, change: 0.00, changePercent: 0.00),
  Watch(sym: 'COIN', shares: 300, price: 70.32, change: 0.00, changePercent: 0.00),
  Watch(sym: 'TSLA', shares: 500, price: 275.98, change: 0.00, changePercent: 0.00),
  Watch(sym: 'T', shares: 1000, price: 16.15, change: 0.00, changePercent: 0.00),
  Watch(sym: 'JPM', shares: 1100, price: 36.77, change: 0.00, changePercent: 0.00),
  Watch(sym: 'GOOGL', shares: 200, price: 399.00, change: 0.00, changePercent: 0.00),
  Watch(sym: 'HOOD', shares: 200, price: 39.03, change: 0.00, changePercent: 0.00),
  Watch(sym: 'BRK.A', shares: 5, price: 4000.30, change: 0.00, changePercent: 0.00),
  Watch(sym: 'NKE', shares: 790, price: 24.05, change: 0.00, changePercent: 0.00),
  Watch(sym: 'NFLX', shares: 450, price: 440.70, change: 0.00, changePercent: 0.00),
  Watch(sym: 'ADBE', shares: 350, price: 140.62, change: 0.00, changePercent: 0.00),
  Watch(sym: 'ORCL', shares: 2000, price: 440.93, change: 0.00, changePercent: 0.00),
];
