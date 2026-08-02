part of 'trading_bloc.dart';

// Events
abstract class TradingEvent extends Equatable {
  const TradingEvent();

  @override
  List<Object?> get props => [];
}

class LoadTradingAccountEvent extends TradingEvent {}

class SubmitOrderEvent extends TradingEvent {
  final String symbol;
  final OrderType type;
  final int quantity;
  final double ltp;

  const SubmitOrderEvent({
    required this.symbol,
    required this.type,
    required this.quantity,
    required this.ltp,
  });

  @override
  List<Object?> get props => [symbol, type, quantity, ltp];
}
