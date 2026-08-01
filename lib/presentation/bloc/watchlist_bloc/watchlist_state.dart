part of 'watchlist_bloc.dart';

class WatchlistState extends Equatable {
  final List<Watchlist> watchlist;
  final int selectedIndex;
  final bool isLoading;

  const WatchlistState({
    this.watchlist = const [],
    this.selectedIndex = 0,
    this.isLoading = false,
  });

  Watchlist? get currentWatchlist {
    if (watchlist.isEmpty) return null;
    int index = selectedIndex;
    if (index >= watchlist.length) index = 0;
    return watchlist[index];
  }

  WatchlistState copyWith({
    List<Watchlist>? watchlist,
    int? selectedIndex,
    bool? isLoading,
  }) {
    return WatchlistState(
      watchlist: watchlist ?? this.watchlist,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [watchlist, selectedIndex, isLoading];
}
