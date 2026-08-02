enum OrderType { buy, sell }

class OrderModel {
  final String id;
  final String symbol;
  final OrderType type;
  final int quantity;
  final double executionPrice;
  final DateTime timestamp;

  OrderModel({
    required this.id,
    required this.symbol,
    required this.type,
    required this.quantity,
    required this.executionPrice,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'symbol': symbol,
    'type': type.name,
    'quantity': quantity,
    'executionPrice': executionPrice,
    'timestamp': timestamp.toIso8601String(),
  };

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json['id'],
    symbol: json['symbol'],
    type: OrderType.values.byName(json['type']),
    quantity: json['quantity'],
    executionPrice: json['executionPrice'],
    timestamp: DateTime.parse(json['timestamp']),
  );
}
