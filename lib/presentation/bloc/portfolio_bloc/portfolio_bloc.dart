import 'package:trade_app/exports/exports.dart';

part 'portfolio_event.dart';

part 'portfolio_state.dart';

enum HoldingsSortType { pnlDescending, pnlAscending, symbol, currentValue }

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final PortfolioRepository repository;

  PortfolioBloc(this.repository) : super(const PortfolioState()) {
    on<LoadHoldingsEvent>(_onLoadHoldings);
    on<SortHoldingsEvent>(_onSortHoldings);
  }

  Future<void> _onLoadHoldings(
      LoadHoldingsEvent event,
      Emitter<PortfolioState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));
    final holdings = await repository.fetchHoldings();
    emit(state.copyWith(holdings: holdings, isLoading: false));
  }

  void _onSortHoldings(SortHoldingsEvent event, Emitter<PortfolioState> emit) {
    // Emitting the new sortType triggers the UI BlocBuilder to re-sort
    // using the latest live market prices and holdings data.
    emit(state.copyWith(sortType: event.sortType));
  }
}
