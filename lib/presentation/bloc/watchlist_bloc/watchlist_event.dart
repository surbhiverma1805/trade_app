part of 'watchlist_bloc.dart';

abstract class WatchlistEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadWatchlist extends WatchlistEvent {}

class SelectWatchlistEvent extends WatchlistEvent {
  final int index;

  SelectWatchlistEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class CreateWatchlistEvent extends WatchlistEvent {
  final String name;

  CreateWatchlistEvent(this.name);

  @override
  List<Object?> get props => [name];
}

class RenameWatchlistEvent extends WatchlistEvent {
  final String id;
  final String newName;

  RenameWatchlistEvent(this.id, this.newName);

  @override
  List<Object?> get props => [id, newName];
}

class DeleteWatchlistEvent extends WatchlistEvent {
  final String id;

  DeleteWatchlistEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class AddStockEvent extends WatchlistEvent {
  final String symbol;

  AddStockEvent(this.symbol);

  @override
  List<Object?> get props => [symbol];
}

class RemoveStockEvent extends WatchlistEvent {
  final String symbol;

  RemoveStockEvent(this.symbol);

  @override
  List<Object?> get props => [symbol];
}

class ReorderStocksEvent extends WatchlistEvent {
  final int oldIndex;
  final int newIndex;

  ReorderStocksEvent(this.oldIndex, this.newIndex);

  @override
  List<Object?> get props => [oldIndex, newIndex];
}
