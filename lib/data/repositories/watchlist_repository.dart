import 'package:trade_app/exports/exports.dart';

class WatchlistRepository {
  final WatchlistService service;

  WatchlistRepository(this.service);

  Future<List<Watchlist>> getWatchlist() async => service.getWatchlist();

  Future<void> saveWatchlist(List<Watchlist> watchlist) async =>
      service.saveWatchlist(watchlist);
}
