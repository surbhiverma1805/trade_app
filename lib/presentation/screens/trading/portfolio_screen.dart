import 'package:trade_app/exports/exports.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        title: Text(
          '${AppStrings.portfolio} / ${AppStrings.holdings}',
          style: TextStyle(
            color: AppColors.deepMidNightColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<TradingBloc, TradingState>(
        builder: (context, state) {
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
                      ),
                    ),
                    Text(
                      '₹${state.balance.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: AppColors.deepMidNightColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.yourHoldings,
                    style: TextStyle(
                      color: AppColors.deepMidNightColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              // Holdings List or Empty State
              Expanded(
                child: state.holdings.isEmpty
                    ? Center(
                        child: Text(
                          AppStrings.noHoldingsYetBuyStocksFromYourWatchlist,
                          style: TextStyle(color: AppColors.slateGreyColor),
                        ),
                      )
                    : ListView.builder(
                        itemCount: state.holdings.length,
                        itemBuilder: (context, index) {
                          final holding = state.holdings[index];
                          return Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 6.w,
                            ),
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.white100Color,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      holding.symbol,
                                      style: TextStyle(
                                        color: AppColors.deepMidNightColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                    4.toSpace(vertically: false),
                                    Text(
                                      '${AppStrings.qty}: ${holding.quantity}',
                                      style: TextStyle(
                                        color: AppColors.slateGreyColor,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${AppStrings.avg}: ₹${holding.averagePrice.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        color: AppColors.deepMidNightColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
