import 'package:trade_app/exports/exports.dart';

void showAddStockSheet(
  BuildContext context,
  List<Stock> allStocks,
  List<String> existingSymbols,
) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.whiteColor,
    builder: (sheetContext) {
      return Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.addStocksToWatchlist,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.deepMidNightColor,
              ),
            ),
            const Divider(color: AppColors.white100Color),
            Expanded(
              child: ListView.builder(
                itemCount: allStocks.length,
                itemBuilder: (context, index) {
                  final stock = allStocks[index];
                  final isAlreadyAdded = existingSymbols.contains(stock.symbol);

                  return ListTile(
                    title: Text(
                      stock.symbol,
                      style: const TextStyle(
                        color: AppColors.deepMidNightColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '₹${stock.ltp.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: isAlreadyAdded
                        ? const Text(
                            AppStrings.added,
                            style: TextStyle(color: AppColors.greyColor),
                          )
                        : IconButton(
                            icon: const Icon(
                              Icons.add_circle,
                              color: AppColors.deepMidNightColor,
                            ),
                            onPressed: () {
                              context.read<WatchlistBloc>().add(
                                AddStockEvent(stock.symbol),
                              );
                              Navigator.pop(sheetContext);
                            },
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
