import 'dart:convert';

import 'package:trade_app/exports/exports.dart';

class WatchlistServiceImpl extends WatchlistService {
  @override
  Future<List<Watchlist>> getWatchlist() async {
    final String encoded = await SharedPre.getStringValue(SharedPre.storageKey);

    if (encoded.isNotEmpty) {
      final List decoded = jsonDecode(encoded);
      return decoded.map((item) => Watchlist.fromJson(item)).toList();
    }
    return [];
  }

  @override
  Future<void> saveWatchlist(List<Watchlist> watchlist) async {
    final String encoded = jsonEncode(
      watchlist.map((item) => item.toJson()).toList(),
    );
    await SharedPre.setString(SharedPre.storageKey, encoded);
  }
}
