class HoldingModel {
  final String symbol;
  int quantity;
  double averagePrice;

  HoldingModel({
    required this.symbol,
    required this.quantity,
    required this.averagePrice,
  });

  Map<String, dynamic> toJson() => {
    'symbol': symbol,
    'quantity': quantity,
    'averagePrice': averagePrice,
  };

  factory HoldingModel.fromJson(Map<String, dynamic> json) => HoldingModel(
    symbol: json['symbol'],
    quantity: json['quantity'],
    averagePrice: json['averagePrice'],
  );
}
