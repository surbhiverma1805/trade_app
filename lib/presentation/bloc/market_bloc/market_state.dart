part of 'market_bloc.dart';

class MarketState extends Equatable {
  final Map<String, Stock> stocks;

  // Track the last updated stock symbol and direction for flashing
  final String? lastUpdatedSymbol;
  final bool? lastDirectionUp;

  const MarketState({
    required this.stocks,
    this.lastUpdatedSymbol,
    this.lastDirectionUp,
  });

  MarketState copyWith({
    Map<String, Stock>? stocks,
    String? lastUpdatedSymbol,
    bool? lastDirectionUp,
  }) => MarketState(
    stocks: stocks ?? this.stocks,
    lastUpdatedSymbol: lastUpdatedSymbol ?? this.lastUpdatedSymbol,
    lastDirectionUp: lastDirectionUp ?? this.lastDirectionUp,
  );

  @override
  List<Object?> get props => [stocks, lastUpdatedSymbol, lastDirectionUp];
}
