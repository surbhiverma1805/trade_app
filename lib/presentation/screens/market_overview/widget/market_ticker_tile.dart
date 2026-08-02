import 'dart:async';

import 'package:trade_app/exports/exports.dart';

class MarketTickerTile extends StatefulWidget {
  final String symbol;

  const MarketTickerTile({required Key key, required this.symbol})
    : super(key: key);

  @override
  State<MarketTickerTile> createState() => _MarketTickerTileState();
}

class _MarketTickerTileState extends State<MarketTickerTile> {
  Color? _flashColor;
  Timer? _flashTimer;

  void _triggerFlash(bool isUp) {
    _flashTimer?.cancel();
    setState(() {
      _flashColor = isUp
          ? AppColors.primary.withValues(alpha: 0.15)
          : AppColors.redColor.withValues(alpha: 0.15);
    });

    _flashTimer = Timer(const Duration(milliseconds: 350), () {
      if (mounted) setState(() => _flashColor = Colors.transparent);
    });
  }

  @override
  void dispose() {
    _flashTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MarketBloc, MarketState>(
      // Only listen/trigger flash if THIS stock's price changed
      listenWhen: (previous, current) =>
          current.lastUpdatedSymbol == widget.symbol &&
          previous.stocks[widget.symbol]?.ltp !=
              current.stocks[widget.symbol]?.ltp,
      listener: (context, state) {
        final isUp = state.lastDirectionUp ?? true;
        _triggerFlash(isUp);
      },
      // Only rebuild this specific row if its data changed
      buildWhen: (previous, current) =>
          previous.stocks[widget.symbol] != current.stocks[widget.symbol],
      builder: (context, state) {
        final stock = state.stocks[widget.symbol]!;
        final isPositive = stock.change >= 0;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: _flashColor ?? AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.white100Color),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stock.symbol,
                    style: TextStyle(
                      color: AppColors.deepMidNightColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  4.toSpace(),
                  Text(
                    '${AppStrings.change}: ${isPositive ? '+' : ''}${stock.change.toStringAsFixed(2)}',
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
                    '₹${stock.ltp.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: AppColors.deepMidNightColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  4.toSpace(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 2.w,
                    ),
                    decoration: BoxDecoration(
                      color:
                          (isPositive ? AppColors.primary : AppColors.redColor)
                              .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${isPositive ? '+' : ''}${stock.changePercent.toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: isPositive
                            ? AppColors.primary
                            : AppColors.redColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
