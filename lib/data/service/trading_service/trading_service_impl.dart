import 'dart:convert';
import 'package:trade_app/exports/exports.dart';

class TradingServiceImpl implements TradingService {
  @override
  Future<double> getWalletBalance() async {
    // Default starting margin/balance: ₹1,00,000
    return SharedPre.getDoubleValue(
      SharedPre.balanceKey,
      defaultValue: 100000.00,
    );
  }

  @override
  Future<void> updateWalletBalance(double newBalance) async {
    await SharedPre.setDouble(SharedPre.balanceKey, newBalance);
  }

  @override
  Future<List<HoldingModel>> getHoldings() async {
    final String data = await SharedPre.getStringValue(SharedPre.holdingsKey);
    if (data.isEmpty) return [];
    final List decoded = jsonDecode(data);
    return decoded.map((e) => HoldingModel.fromJson(e)).toList();
  }

  @override
  Future<void> saveHoldings(List<HoldingModel> holdings) async {
    final String encoded = jsonEncode(holdings.map((e) => e.toJson()).toList());
    await SharedPre.setString(SharedPre.holdingsKey, encoded);
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    final String data = await SharedPre.getStringValue(SharedPre.ordersKey);
    if (data.isEmpty) return [];
    final List decoded = jsonDecode(data);
    return decoded.map((e) => OrderModel.fromJson(e)).toList();
  }

  @override
  Future<void> saveOrders(List<OrderModel> orders) async {
    final String encoded = jsonEncode(orders.map((e) => e.toJson()).toList());
    await SharedPre.setString(SharedPre.ordersKey, encoded);
  }
}
