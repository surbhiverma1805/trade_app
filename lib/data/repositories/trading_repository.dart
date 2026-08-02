import 'package:trade_app/exports/exports.dart';

class TradingRepository {
  final TradingService service;

  TradingRepository(this.service);

  Future<double> fetchWalletBalance() => service.getWalletBalance();

  Future<List<HoldingModel>> fetchHoldings() => service.getHoldings();

  Future<List<OrderModel>> fetchOrders() => service.getOrders();

  Future<bool> executeOrder({
    required String symbol,
    required OrderType type,
    required int quantity,
    required double ltp,
  }) async {
    final balance = await service.getWalletBalance();
    final holdings = await service.getHoldings();
    final orders = await service.getOrders();

    final double totalOrderValue = double.parse(
      (quantity * ltp).toStringAsFixed(2),
    );

    if (type == OrderType.buy) {
      if (balance < totalOrderValue) return false; // Insufficient funds

      // Deduct balance
      final newBalance = double.parse(
        (balance - totalOrderValue).toStringAsFixed(2),
      );
      await service.updateWalletBalance(newBalance);

      // Update Holdings
      final index = holdings.indexWhere((h) => h.symbol == symbol);
      if (index >= 0) {
        final existing = holdings[index];
        final newQty = existing.quantity + quantity;
        final newAvgPrice =
            ((existing.quantity * existing.averagePrice) + totalOrderValue) /
            newQty;
        holdings[index] = HoldingModel(
          symbol: symbol,
          quantity: newQty,
          averagePrice: newAvgPrice,
        );
      } else {
        holdings.add(
          HoldingModel(symbol: symbol, quantity: quantity, averagePrice: ltp),
        );
      }
    } else {
      // Sell Logic
      final index = holdings.indexWhere((h) => h.symbol == symbol);
      if (index < 0) return false; // Don't own any

      final existing = holdings[index];
      if (existing.quantity < quantity) return false; // Over-selling

      // Add funds back to wallet
      final newBalance = double.parse(
        (balance + totalOrderValue).toStringAsFixed(2),
      );
      await service.updateWalletBalance(newBalance);

      if (existing.quantity == quantity) {
        holdings.removeAt(index);
      } else {
        holdings[index] = HoldingModel(
          symbol: symbol,
          quantity: existing.quantity - quantity,
          averagePrice: existing.averagePrice,
        );
      }
    }

    // Save Holdings
    await service.saveHoldings(holdings);

    // Record Order
    final newOrder = OrderModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      symbol: symbol,
      type: type,
      quantity: quantity,
      executionPrice: ltp,
      timestamp: DateTime.now(),
    );
    orders.insert(0, newOrder);
    await service.saveOrders(orders);

    return true;
  }
}
