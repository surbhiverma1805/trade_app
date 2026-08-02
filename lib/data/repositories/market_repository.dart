import 'package:trade_app/exports/exports.dart';

class MarketRepository {
  final MarketService _marketService;

  MarketRepository(this._marketService);

  Stream<Map<String, Stock>> getMarketPrices() {
    return _marketService.priceStream;
  }

  Map<String, Stock> getInitialStocks() {
    return _marketService.currentStocks;
  }

  void startPriceStream() {
    _marketService.startStreaming();
  }

  void stopPriceStream() {
    _marketService.stopStreaming();
  }
}
