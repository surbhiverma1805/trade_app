import 'package:trade_app/exports/exports.dart';

class StockItem extends StatelessWidget {
  const StockItem({
    super.key,
    required this.symbol,
    required this.stock,
    required this.isPositive,
  });

  final String symbol;
  final Stock stock;
  final bool isPositive;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(symbol),
      margin: EdgeInsets.only(bottom: 8.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: AppColors.white100Color, width: 1),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
        title: Text(
          stock.symbol,
          style: TextStyle(
            color: AppColors.deepMidNightColor,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4.w),
          child: Text(
            '${AppStrings.change}: ${isPositive ? '+' : ''}${stock.change.toStringAsFixed(2)}',
            style: TextStyle(color: Colors.grey[600], fontSize: 13.sp),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹${stock.ltp.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: AppColors.deepMidNightColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                2.toSpace(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.w),
                  decoration: BoxDecoration(
                    color:
                        (isPositive ? AppColors.greenColor : AppColors.redColor)
                            .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${isPositive ? '+' : ''}${stock.changePercent.toStringAsFixed(2)}%',
                    style: TextStyle(
                      color: isPositive ? Colors.green[700] : Colors.red[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            12.toSpace(vertically: false),
            IconButton(
              icon: Icon(Icons.delete_outline, color: AppColors.slateGreyColor),
              onPressed: () {
                context.read<WatchlistBloc>().add(RemoveStockEvent(symbol));
              },
            ),
          ],
        ),
        onTap: () {
          // TODO: Open Buy/Sell Ticket pre-filled with this stock
        },
      ),
    );
  }
}
