import 'package:trade_app/exports/exports.dart';

abstract class WatchlistService {

  Future<List<Watchlist>> getWatchlist();

  Future<void> saveWatchlist(List<Watchlist> watchlist);
}
