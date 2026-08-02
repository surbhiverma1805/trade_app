import 'package:trade_app/exports/exports.dart';

abstract class PortfolioService {
  Future<List<HoldingModel>> getHoldings();

  Future<void> saveHoldings(List<HoldingModel> holdings);
}
