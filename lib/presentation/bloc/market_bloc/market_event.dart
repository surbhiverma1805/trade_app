part of 'market_bloc.dart';

abstract class MarketEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartMarketStreamEvent extends MarketEvent {}

class TickPricesEvent extends MarketEvent {
  final Map<String, Stock> updatedStock;

  TickPricesEvent(this.updatedStock);

  @override
  List<Object?> get props => [updatedStock];
}
