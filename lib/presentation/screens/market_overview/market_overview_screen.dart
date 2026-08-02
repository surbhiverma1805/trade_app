import 'package:trade_app/exports/exports.dart';

class MarketOverviewScreen extends StatelessWidget {
  const MarketOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final marketRepository = RepositoryProvider.of<MarketRepository>(context);
    final symbols = marketRepository.getInitialStocks().keys.toList();

    return BlocProvider(
      create: (context) =>
          MarketBloc(marketRepository)..add(StartMarketStreamEvent()),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          title: Text(
            AppStrings.marketOverview,
            style: TextStyle(
              color: AppColors.deepMidNightColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8.w),
          itemCount: symbols.length,
          itemBuilder: (context, index) {
            final symbol = symbols[index];
            return MarketTickerTile(key: ValueKey(symbol), symbol: symbol);
          },
        ),
      ),
    );
  }
}
