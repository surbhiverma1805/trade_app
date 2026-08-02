part of 'trading_bloc.dart';

// State
class TradingState extends Equatable {
  final double balance;
  final List<HoldingModel> holdings;
  final List<OrderModel> orders;
  final bool isSubmitting;
  final String? errorMessage;
  final bool orderSuccess;

  const TradingState({
    this.balance = 100000.0,
    this.holdings = const [],
    this.orders = const [],
    this.isSubmitting = false,
    this.errorMessage,
    this.orderSuccess = false,
  });

  TradingState copyWith({
    double? balance,
    List<HoldingModel>? holdings,
    List<OrderModel>? orders,
    bool? isSubmitting,
    String? errorMessage,
    bool? orderSuccess,
  }) {
    return TradingState(
      balance: balance ?? this.balance,
      holdings: holdings ?? this.holdings,
      orders: orders ?? this.orders,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
      orderSuccess: orderSuccess ?? false,
    );
  }

  @override
  List<Object?> get props => [
    balance,
    holdings,
    orders,
    isSubmitting,
    errorMessage,
    orderSuccess,
  ];
}
