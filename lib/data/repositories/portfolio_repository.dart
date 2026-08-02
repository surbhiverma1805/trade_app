import 'package:trade_app/exports/exports.dart';

class PortfolioRepository {
  final PortfolioService service;

  PortfolioRepository(this.service);

  Future<List<HoldingModel>> fetchHoldings() => service.getHoldings();
}
