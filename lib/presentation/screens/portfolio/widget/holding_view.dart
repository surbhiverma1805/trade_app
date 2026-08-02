import 'package:trade_app/exports/exports.dart';

class HoldingView extends StatelessWidget {
  const HoldingView({
    super.key,
    required this.holding,
    required this.currentValue,
    required this.pnl,
    required this.pnlPercentage,
    required this.itemIsProfit,
  });

  final HoldingModel holding;
  final double currentValue;
  final double pnl;
  final double pnlPercentage;
  final bool itemIsProfit;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.white100Color),
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
                '${AppStrings.qty}: ${holding.quantity}  •  ${AppStrings.avg}: ₹${holding.averagePrice.toStringAsFixed(2)}',
                style: TextStyle(
                  color: AppColors.slateGreyColor,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹${currentValue.toStringAsFixed(2)}',
                style: TextStyle(
                  color: AppColors.deepMidNightColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),
              4.toSpace(vertically: false),
              Text(
                '${itemIsProfit ? '+' : ''}₹${pnl.toStringAsFixed(2)} (${itemIsProfit ? '+' : ''}${pnlPercentage.toStringAsFixed(2)}%)',
                style: TextStyle(
                  color: itemIsProfit ? AppColors.primary : AppColors.redColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
