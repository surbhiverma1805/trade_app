import 'dart:async';
import 'package:trade_app/exports/exports.dart';

abstract class MarketService {
  Stream<Map<String, Stock>> get priceStream;

  Map<String, Stock> get currentStocks;

  void startStreaming({Duration tickRate = const Duration(milliseconds: 300)});

  void stopStreaming();
}
