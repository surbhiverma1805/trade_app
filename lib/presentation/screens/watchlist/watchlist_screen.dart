import 'package:trade_app/exports/exports.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final allMasterStocks = Stock.getInitialStocks();

    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, state) {
        final currentList = state.currentWatchlist;

        return Scaffold(
          backgroundColor: AppColors.bgColor,
          // Light professional background
          appBar: AppBar(
            backgroundColor: AppColors.whiteColor,
            elevation: 0.5,
            title: const Text(
              AppStrings.watchlist,
              style: TextStyle(
                color: AppColors.deepMidNightColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.add, color: AppColors.deepMidNightColor),
                tooltip: AppStrings.createWatchlist,
                onPressed: () => showCreateDialog(context),
              ),
            ],
            bottom: state.watchlist.isNotEmpty
                ? PreferredSize(
                    preferredSize: Size.fromHeight(55.w),
                    child: Container(
                      color: AppColors.whiteColor,
                      height: 55.w,
                      padding: EdgeInsets.symmetric(vertical: 8.w),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.watchlist.length,
                        itemBuilder: (context, index) {
                          final wl = state.watchlist[index];
                          final isSelected = index == state.selectedIndex;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6.0,
                            ),
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                if (!isSelected) {
                                  context.read<WatchlistBloc>().add(
                                    SelectWatchlistEvent(index),
                                  );
                                }
                              },
                              child: WatchlistItem(
                                isSelected: isSelected,
                                watchlist: wl,
                                watchListLen: state.watchlist.length,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : null,
          ),
          body: state.isLoading
              ? Loader()
              : currentList == null || currentList.stockSymbols.isEmpty
              ? NoStocksView(
                  onPressed: () => showAddStockSheet(
                    context,
                    allMasterStocks,
                    currentList?.stockSymbols ?? [],
                  ),
                )
              : ReorderableListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: currentList.stockSymbols.length,
                  proxyDecorator: (child, index, animation) {
                    return Material(
                      color: Colors.transparent,
                      elevation: 6,
                      // Adds a nice floating shadow effect while dragging
                      shadowColor: Colors.black26,
                      borderRadius: BorderRadius.circular(12),
                      child:
                          child, // Keeps your original StockItem layout intact
                    );
                  },
                  itemBuilder: (context, index) {
                    final symbol = currentList.stockSymbols[index];
                    final stock = allMasterStocks.firstWhere(
                      (s) => s.symbol == symbol,
                      orElse: () => Stock(
                        symbol: symbol,
                        ltp: 0,
                        change: 0,
                        changePercent: 0,
                      ),
                    );

                    final isPositive = stock.change >= 0;

                    return StockItem(
                      key: ValueKey(symbol),
                      symbol: symbol,
                      stock: stock,
                      isPositive: isPositive,
                    );
                  },
                  onReorder: (int oldIndex, int newIndex) {
                    // Dispatch the reorder event to your BLoC
                    context.read<WatchlistBloc>().add(
                      ReorderStocksEvent(oldIndex, newIndex),
                    );
                  },
                ),
          floatingActionButton:
              currentList != null && currentList.stockSymbols.isNotEmpty
              ? FloatingActionButton(
                  backgroundColor: AppColors.deepMidNightColor,
                  onPressed: () => showAddStockSheet(
                    context,
                    allMasterStocks,
                    currentList.stockSymbols,
                  ),
                  tooltip: 'Add Stock',
                  child: const Icon(Icons.add, color: Colors.white),
                )
              : null,
        );
      },
    );
  }
}
