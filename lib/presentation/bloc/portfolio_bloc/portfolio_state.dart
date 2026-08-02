part of 'portfolio_bloc.dart';

class PortfolioState extends Equatable {
  final List<HoldingModel> holdings;
  final HoldingsSortType sortType;
  final bool isLoading;

  const PortfolioState({
    this.holdings = const [],
    this.sortType = HoldingsSortType.pnlDescending,
    this.isLoading = false,
  });

  PortfolioState copyWith({
    List<HoldingModel>? holdings,
    HoldingsSortType? sortType,
    bool? isLoading,
  }) {
    return PortfolioState(
      holdings: holdings ?? this.holdings,
      sortType: sortType ?? this.sortType,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [holdings, sortType, isLoading];
}
