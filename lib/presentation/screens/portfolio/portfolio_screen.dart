import 'package:trade_app/exports/exports.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PortfolioBloc(RepositoryProvider.of<PortfolioRepository>(context))
            ..add(LoadHoldingsEvent()),
      child: const PortfolioView(),
    );
  }
}

class PortfolioView extends StatelessWidget {
  const PortfolioView({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to global TradingBloc to auto-refresh when orders are placed
    return BlocListener<TradingBloc, TradingState>(
      listener: (context, tradingState) {
        context.read<PortfolioBloc>().add(LoadHoldingsEvent());
      },
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          title: Text(
            '${AppStrings.portfolio} / ${AppStrings.holdings}',
            style: TextStyle(
              color: AppColors.deepMidNightColor,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          actions: [
            PopupMenuButton<HoldingsSortType>(
              icon: const Icon(
                Icons.sort_rounded,
                color: AppColors.deepMidNightColor,
              ),
              onSelected: (sortType) {
                context.read<PortfolioBloc>().add(SortHoldingsEvent(sortType));
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: HoldingsSortType.pnlDescending,
                  child: Text(AppStrings.sortPnlHighToLow),
                ),
                PopupMenuItem(
                  value: HoldingsSortType.pnlAscending,
                  child: Text(AppStrings.sortPnlLowToHigh),
                ),
                PopupMenuItem(
                  value: HoldingsSortType.symbol,
                  child: Text(AppStrings.sortSymbol),
                ),
                PopupMenuItem(
                  value: HoldingsSortType.currentValue,
                  child: Text(AppStrings.sortCurrentValue),
                ),
              ],
            ),
          ],
        ),
        body: BlocBuilder<PortfolioBloc, PortfolioState>(
          builder: (context, portfolioState) {
            if (portfolioState.isLoading) {
              return const Center(child: Loader());
            }

            return BlocBuilder<TradingBloc, TradingState>(
              builder: (context, tradingState) {
                return BlocBuilder<MarketBloc, MarketState>(
                  builder: (context, marketState) {
                    double totalInvested = 0;
                    double totalCurrentValue = 0;

                    // Calculate metrics dynamically using live LTP from MarketBloc and Holdings from PortfolioBloc
                    final evaluatedHoldings = portfolioState.holdings.map((
                      holding,
                    ) {
                      final stock = marketState.stocks[holding.symbol];
                      final ltp = stock?.ltp ?? holding.averagePrice;
                      final invested = holding.quantity * holding.averagePrice;
                      final currentValue = holding.quantity * ltp;
                      final pnl = currentValue - invested;
                      final pnlPercentage = invested > 0
                          ? (pnl / invested) * 100
                          : 0.0;

                      totalInvested += invested;
                      totalCurrentValue += currentValue;

                      return {
                        'holding': holding,
                        'ltp': ltp,
                        'invested': invested,
                        'currentValue': currentValue,
                        'pnl': pnl,
                        'pnlPercentage': pnlPercentage,
                      };
                    }).toList();

                    // Apply Sorting rules
                    evaluatedHoldings.sort((a, b) {
                      switch (portfolioState.sortType) {
                        case HoldingsSortType.pnlAscending:
                          return (a['pnl'] as double).compareTo(
                            b['pnl'] as double,
                          );
                        case HoldingsSortType.symbol:
                          return (a['holding'] as HoldingModel).symbol
                              .compareTo((b['holding'] as HoldingModel).symbol);
                        case HoldingsSortType.currentValue:
                          return (b['currentValue'] as double).compareTo(
                            a['currentValue'] as double,
                          );
                        case HoldingsSortType.pnlDescending:
                          return (b['pnl'] as double).compareTo(
                            a['pnl'] as double,
                          );
                      }
                    });

                    final totalPnl = totalCurrentValue - totalInvested;
                    final totalPnlPercentage = totalInvested > 0
                        ? (totalPnl / totalInvested) * 100
                        : 0.0;
                    final isProfit = totalPnl >= 0;

                    return Column(
                      children: [
                        // Wallet Summary Card
                        Container(
                          margin: EdgeInsets.all(16.w),
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.white100Color),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.walletBalance,
                                style: TextStyle(
                                  color: AppColors.slateGreyColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                '₹${tradingState.balance.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: AppColors.deepMidNightColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Aggregate Summary Card (Total P&L / Invested / Current Value)
                        if (portfolioState.holdings.isNotEmpty)
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.w),
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.white100Color,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppStrings.totalPnl,
                                      style: TextStyle(
                                        color: AppColors.slateGreyColor,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                    Text(
                                      '${isProfit ? '+' : ''}₹${totalPnl.toStringAsFixed(2)} (${isProfit ? '+' : ''}${totalPnlPercentage.toStringAsFixed(2)}%)',
                                      style: TextStyle(
                                        color: isProfit
                                            ? AppColors.primary
                                            : AppColors.redColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                12.toSpace(),
                                const Divider(color: AppColors.white100Color),
                                12.toSpace(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppStrings.invested,
                                          style: TextStyle(
                                            color: AppColors.slateGreyColor,
                                            fontSize: 11.sp,
                                          ),
                                        ),
                                        4.toSpace(),
                                        Text(
                                          '₹${totalInvested.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            color: AppColors.deepMidNightColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          AppStrings.currentValue,
                                          style: TextStyle(
                                            color: AppColors.slateGreyColor,
                                            fontSize: 11.sp,
                                          ),
                                        ),
                                        4.toSpace(),
                                        Text(
                                          '₹${totalCurrentValue.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            color: AppColors.deepMidNightColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.w,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppStrings.yourHoldings,
                              style: TextStyle(
                                color: AppColors.deepMidNightColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),

                        // Holdings List or Empty State
                        Expanded(
                          child: portfolioState.holdings.isEmpty
                              ? Center(
                                  child: Text(
                                    AppStrings
                                        .noHoldingsYetBuyStocksFromYourWatchlist,
                                    style: TextStyle(
                                      color: AppColors.slateGreyColor,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: evaluatedHoldings.length,
                                  itemBuilder: (context, index) {
                                    final item = evaluatedHoldings[index];
                                    final holding =
                                        item['holding'] as HoldingModel;
                                    final currentValue =
                                        item['currentValue'] as double;
                                    final pnl = item['pnl'] as double;
                                    final pnlPercentage =
                                        item['pnlPercentage'] as double;
                                    final itemIsProfit = pnl >= 0;

                                    return GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          builder: (context) =>
                                              BuySellTicketScreen(
                                                symbol: holding.symbol,
                                                initialType: OrderType.buy,
                                              ),
                                        );
                                      },
                                      child: HoldingView(
                                        holding: holding,
                                        currentValue: currentValue,
                                        pnl: pnl,
                                        pnlPercentage: pnlPercentage,
                                        itemIsProfit: itemIsProfit,
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
