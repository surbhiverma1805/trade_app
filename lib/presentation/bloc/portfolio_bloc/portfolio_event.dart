part of 'portfolio_bloc.dart';

abstract class PortfolioEvent extends Equatable {
  const PortfolioEvent();
  @override
  List<Object?> get props => [];
}

class LoadHoldingsEvent extends PortfolioEvent {}

class SortHoldingsEvent extends PortfolioEvent {
  final HoldingsSortType sortType;
  const SortHoldingsEvent(this.sortType);
  @override
  List<Object?> get props => [sortType];
}