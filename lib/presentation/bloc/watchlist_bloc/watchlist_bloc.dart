import 'package:trade_app/exports/exports.dart';

part 'watchlist_event.dart';

part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistRepository repository;

  WatchlistBloc(this.repository) : super(WatchlistState()) {
    on<LoadWatchlist>(_onLoadWatchlist);
    on<SelectWatchlistEvent>(_onSelectWatchlistEvent);
    on<CreateWatchlistEvent>(_onCreateWatchlistEvent);
    on<RenameWatchlistEvent>(_onRenameWatchlistEvent);
    on<DeleteWatchlistEvent>(_onDeleteWatchlistEvent);
    on<AddStockEvent>(_onAddStockEvent);
    on<RemoveStockEvent>(_onRemoveStockEvent);
    on<ReorderStocksEvent>(_onReorderStocksEvent);

    add(LoadWatchlist());
  }

  Future<void> _onLoadWatchlist(
    LoadWatchlist event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    List<Watchlist> loadedList = await repository.getWatchlist();

    if (loadedList.isEmpty) {
      loadedList = [
        Watchlist(
          id: const Uuid().v4(),
          name: 'My Watchlist 1',
          stockSymbols: ['RELIANCE', 'TCS', 'INFY'],
        ),
      ];
    }

    emit(
      state.copyWith(watchlist: loadedList, isLoading: false, selectedIndex: 0),
    );
  }

  void _onSelectWatchlistEvent(
    SelectWatchlistEvent event,
    Emitter<WatchlistState> emit,
  ) {
    emit(state.copyWith(selectedIndex: event.index));
  }

  Future<void> _onCreateWatchlistEvent(
    CreateWatchlistEvent event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    // Create the new watchlist item
    final newWatchlist = Watchlist(
      id: const Uuid().v4(),
      name: event.name,
      stockSymbols: [],
    );

    // Build the updated list
    final updatedLists = List<Watchlist>.from(state.watchlist)
      ..add(newWatchlist);

    // Emit the new state immediately for a responsive UI
    emit(
      state.copyWith(
        watchlist: updatedLists,
        selectedIndex: updatedLists.length - 1,
        isLoading: false,
      ),
    );

    // Delegate persistence transparently to your repository/service layer
    await repository.saveWatchlist(updatedLists);
  }

  Future<void> _onRenameWatchlistEvent(
    RenameWatchlistEvent event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final updatedLists = state.watchlist.map((wl) {
      if (wl.id == event.id) {
        return Watchlist(
          id: wl.id,
          name: event.newName,
          stockSymbols: wl.stockSymbols,
        );
      }
      return wl;
    }).toList();

    emit(state.copyWith(watchlist: updatedLists, isLoading: false));
    await repository.saveWatchlist(updatedLists);
  }

  Future<void> _onDeleteWatchlistEvent(
    DeleteWatchlistEvent event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final updatedLists = state.watchlist
        .where((wl) => wl.id != event.id)
        .toList();
    int newIndex = state.selectedIndex;
    if (newIndex >= updatedLists.length) {
      newIndex = updatedLists.isNotEmpty ? updatedLists.length - 1 : 0;
    }

    emit(
      state.copyWith(
        watchlist: updatedLists,
        selectedIndex: newIndex,
        isLoading: false,
      ),
    );
    await repository.saveWatchlist(updatedLists);
  }

  Future<void> _onAddStockEvent(
    AddStockEvent event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final current = state.currentWatchlist;
    if (current == null || current.stockSymbols.contains(event.symbol)) return;

    current.stockSymbols.add(event.symbol);
    final updatedLists = List<Watchlist>.from(state.watchlist);

    emit(state.copyWith(watchlist: updatedLists, isLoading: false));
    await repository.saveWatchlist(updatedLists);
  }

  Future<void> _onRemoveStockEvent(
    RemoveStockEvent event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final current = state.currentWatchlist;
    if (current == null) return;

    current.stockSymbols.remove(event.symbol);
    final updatedLists = List<Watchlist>.from(state.watchlist);

    emit(state.copyWith(watchlist: updatedLists, isLoading: false));
    await repository.saveWatchlist(updatedLists);
  }

  Future<void> _onReorderStocksEvent(
    ReorderStocksEvent event,
    Emitter<WatchlistState> emit,
  ) async {
    final current = state.currentWatchlist;
    if (current == null) return;

    int oldIndex = event.oldIndex;
    int newIndex = event.newIndex;
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final String item = current.stockSymbols.removeAt(oldIndex);
    current.stockSymbols.insert(newIndex, item);

    final updatedLists = List<Watchlist>.from(state.watchlist);
    emit(state.copyWith(watchlist: updatedLists));
    await repository.saveWatchlist(updatedLists);
  }
}
