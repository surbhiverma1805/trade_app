class Watchlist {
  final String id;
  String name;
  List<String> stockSymbols;

  Watchlist({required this.id, required this.name, required this.stockSymbols});

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'stockSymbols': stockSymbols,
  };

  factory Watchlist.fromJson(Map<String, dynamic> json) => Watchlist(
    id: json['id'],
    name: json['name'],
    stockSymbols: List<String>.from(json['stockSymbols']),
  );
}
