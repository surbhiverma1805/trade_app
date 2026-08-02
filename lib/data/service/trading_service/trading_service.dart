import 'package:trade_app/data/model/trading_feature/holding_model.dart';
import 'package:trade_app/data/model/trading_feature/order_model.dart';

abstract class TradingService {
  Future<double> getWalletBalance();

  Future<void> updateWalletBalance(double newBalance);

  Future<List<HoldingModel>> getHoldings();

  Future<void> saveHoldings(List<HoldingModel> holdings);

  Future<List<OrderModel>> getOrders();

  Future<void> saveOrders(List<OrderModel> orders);
}
