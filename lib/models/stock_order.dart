class StockOrder {
  final String id;
  final String productName;
  final int quantity;
  final String status;

  StockOrder({
    required this.id,
    required this.productName,
    required this.quantity,
    required this.status,
  });

  factory StockOrder.fromJson(Map<String, dynamic> json) {
    return StockOrder(
      id: json['id'],
      productName: json['productName'],
      quantity: json['quantity'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'quantity': quantity,
      'status': status,
    };
  }
}
