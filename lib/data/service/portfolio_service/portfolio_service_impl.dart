import 'dart:convert';
import 'package:trade_app/exports/exports.dart';

class PortfolioServiceImpl implements PortfolioService {
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
}
