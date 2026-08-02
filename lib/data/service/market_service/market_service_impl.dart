import 'dart:async';
import 'dart:math';

import 'package:trade_app/exports/exports.dart';

class MarketServiceImpl implements MarketService {
  final Random _random = Random();
  Timer? _timer;

  // Initial 10 master stocks
  final Map<String, Stock> _stocks = {
    'RELIANCE': Stock(
      symbol: 'RELIANCE',
      ltp: 2450.00,
      change: 15.50,
      changePercent: 0.64,
    ),
    'TCS': Stock(
      symbol: 'TCS',
      ltp: 3520.00,
      change: -12.30,
      changePercent: -0.35,
    ),
    'INFY': Stock(
      symbol: 'INFY',
      ltp: 1480.00,
      change: 8.20,
      changePercent: 0.56,
    ),
    'HDFCBANK': Stock(
      symbol: 'HDFCBANK',
      ltp: 1650.00,
      change: 5.00,
      changePercent: 0.30,
    ),
    'ICICIBANK': Stock(
      symbol: 'ICICIBANK',
      ltp: 980.00,
      change: -4.10,
      changePercent: -0.42,
    ),
    'SBIN': Stock(
      symbol: 'SBIN',
      ltp: 600.00,
      change: 2.50,
      changePercent: 0.42,
    ),
    'BHARTIARTL': Stock(
      symbol: 'BHARTIARTL',
      ltp: 870.00,
      change: 12.00,
      changePercent: 1.40,
    ),
    'ITC': Stock(
      symbol: 'ITC',
      ltp: 440.00,
      change: -0.80,
      changePercent: -0.18,
    ),
    'KOTAKBANK': Stock(
      symbol: 'KOTAKBANK',
      ltp: 1800.00,
      change: -15.00,
      changePercent: -0.83,
    ),
    'LT': Stock(symbol: 'LT', ltp: 2900.00, change: 25.00, changePercent: 0.87),
  };

  final _controller = StreamController<Map<String, Stock>>.broadcast();

  @override
  Stream<Map<String, Stock>> get priceStream => _controller.stream;

  @override
  Map<String, Stock> get currentStocks => Map.unmodifiable(_stocks);

  @override
  void startStreaming({Duration tickRate = const Duration(milliseconds: 300)}) {
    _timer?.cancel();
    _timer = Timer.periodic(tickRate, (timer) {
      final keys = _stocks.keys.toList();
      final randomKey = keys[_random.nextInt(keys.length)];
      final stock = _stocks[randomKey]!;

      // Simulate price movement (-0.5% to +0.5%)
      final fluctuationPercent = (_random.nextDouble() * 1.0 - 0.48) / 100;
      final newLtp = stock.ltp * (1 + fluctuationPercent);
      final priceDiff = newLtp - stock.ltp;

      _stocks[randomKey] = Stock(
        symbol: stock.symbol,
        ltp: double.parse(newLtp.toStringAsFixed(2)),
        change: double.parse((stock.change + priceDiff).toStringAsFixed(2)),
        changePercent: double.parse(
          (stock.changePercent + (fluctuationPercent * 100)).toStringAsFixed(2),
        ),
      );

      // Emit the updated stock map
      _controller.add(Map.from(_stocks));
    });
  }

  @override
  void stopStreaming() {
    _timer?.cancel();
  }
}
