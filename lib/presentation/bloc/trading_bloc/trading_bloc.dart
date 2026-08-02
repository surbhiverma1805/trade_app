import 'package:trade_app/exports/exports.dart';

part 'trading_event.dart';

part 'trading_state.dart';

class TradingBloc extends Bloc<TradingEvent, TradingState> {
  final TradingRepository repository;

  TradingBloc(this.repository) : super(const TradingState()) {
    on<LoadTradingAccountEvent>(_onLoadAccount);
    on<SubmitOrderEvent>(_onSubmitOrder);
  }

  Future<void> _onLoadAccount(
    LoadTradingAccountEvent event,
    Emitter<TradingState> emit,
  ) async {
    final balance = await repository.fetchWalletBalance();
    final holdings = await repository.fetchHoldings();
    final orders = await repository.fetchOrders();
    emit(state.copyWith(balance: balance, holdings: holdings, orders: orders));
  }

  Future<void> _onSubmitOrder(
    SubmitOrderEvent event,
    Emitter<TradingState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    final success = await repository.executeOrder(
      symbol: event.symbol,
      type: event.type,
      quantity: event.quantity,
      ltp: event.ltp,
    );

    if (!success) {
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: event.type == OrderType.buy
              ? AppStrings.insufficientBalanceForThisOrder
              : AppStrings.insufficientQuantityHeldToSell,
          orderSuccess: false,
        ),
      );
      return;
    }

    // Refresh state data
    final balance = await repository.fetchWalletBalance();
    final holdings = await repository.fetchHoldings();
    final orders = await repository.fetchOrders();

    emit(
      state.copyWith(
        balance: balance,
        holdings: holdings,
        orders: orders,
        isSubmitting: false,
        orderSuccess: true,
      ),
    );
  }
}
