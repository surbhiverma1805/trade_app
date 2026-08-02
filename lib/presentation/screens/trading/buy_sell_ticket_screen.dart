import 'package:trade_app/exports/exports.dart';

class BuySellTicketScreen extends StatefulWidget {
  final String symbol;
  final OrderType initialType;

  const BuySellTicketScreen({
    super.key,
    required this.symbol,
    this.initialType = OrderType.buy,
  });

  @override
  State<BuySellTicketScreen> createState() => _BuySellTicketScreenState();
}

class _BuySellTicketScreenState extends State<BuySellTicketScreen> {
  late OrderType _orderType;
  final TextEditingController _qtyController = TextEditingController(text: '1');
  String? _validationError;

  @override
  void initState() {
    super.initState();
    _orderType = widget.initialType;
  }

  @override
  void dispose() {
    _qtyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TradingBloc, TradingState>(
      listener: (context, state) {
        if (state.orderSuccess) {
          // Tell the global TradingBloc to refresh holdings and balance immediately
          BlocProvider.of<TradingBloc>(context).add(LoadTradingAccountEvent());
          Navigator.pop(context); // Close sheet on success
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppStrings.orderExecutedSuccessfully),
              backgroundColor: AppColors.primary,
            ),
          );
        }
      },
      builder: (context, tradingState) {
        // Listen to Live Price Stream from MarketBloc
        return BlocBuilder<MarketBloc, MarketState>(
          builder: (context, marketState) {
            final stock = marketState.stocks[widget.symbol];
            final double ltp = stock?.ltp ?? 0.00;

            int qty = int.tryParse(_qtyController.text) ?? 0;
            double totalValue = double.parse((qty * ltp).toStringAsFixed(2));

            // Check holdings for Sell validation
            final holding = tradingState.holdings.firstWhere(
              (h) => h.symbol == widget.symbol,
              orElse: () => HoldingModel(
                symbol: widget.symbol,
                quantity: 0,
                averagePrice: 0,
              ),
            );

            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20.w,
                right: 20.w,
                top: 20.w,
              ),
              decoration: const BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.symbol,
                          style: TextStyle(
                            color: AppColors.deepMidNightColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '₹${ltp.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: AppColors.deepMidNightColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    16.toSpace(),

                    // Buy / Sell Toggle Tabs
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.semiWhiteColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _orderType = OrderType.buy),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 12.w),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: _orderType == OrderType.buy
                                      ? AppColors.primary
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  AppStrings.buy,
                                  style: TextStyle(
                                    color: _orderType == OrderType.buy
                                        ? AppColors.whiteColor
                                        : AppColors.semiBlackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _orderType = OrderType.sell),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 12.w),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: _orderType == OrderType.sell
                                      ? AppColors.redColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  AppStrings.sell,
                                  style: TextStyle(
                                    color: _orderType == OrderType.sell
                                        ? AppColors.whiteColor
                                        : AppColors.semiBlackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    20.toSpace(),

                    // Quantity Input Field
                    TextField(
                      controller: _qtyController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        color: AppColors.deepMidNightColor,
                        // Ensures the typed text stands out clearly
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (val) => setState(() {}),
                      decoration: InputDecoration(
                        labelText: AppStrings.quantity,
                        labelStyle: const TextStyle(
                          color: AppColors.slateGreyColor,
                        ),
                        filled: true,
                        fillColor: AppColors.bgColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    12.toSpace(),

                    // Balance / Holdings info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _orderType == OrderType.buy
                              ? '${AppStrings.availableBalance}: ₹${tradingState.balance.toStringAsFixed(2)}'
                              : '${AppStrings.availableQtyHeld}: ${holding.quantity}',
                          style: TextStyle(
                            color: AppColors.slateGreyColor,
                            fontSize: 13.sp,
                          ),
                        ),
                        Text(
                          '${AppStrings.req}: ₹${totalValue.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: AppColors.deepMidNightColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                    8.toSpace(),

                    // Error message display
                    if (_validationError != null ||
                        tradingState.errorMessage != null)
                      Text(
                        _validationError ?? tradingState.errorMessage!,
                        style: TextStyle(
                          color: AppColors.redColor,
                          fontSize: 12.sp,
                        ),
                      ),
                    20.toSpace(),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 50.w,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _orderType == OrderType.buy
                              ? AppColors.primary
                              : AppColors.redColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        onPressed: tradingState.isSubmitting
                            ? null
                            : () {
                                final enteredQty = int.tryParse(
                                  _qtyController.text,
                                );
                                if (enteredQty == null || enteredQty <= 0) {
                                  setState(
                                    () => _validationError =
                                        AppStrings.pleaseEnterAValidQuantity,
                                  );
                                  return;
                                }
                                setState(() => _validationError = null);

                                if (_orderType == OrderType.buy &&
                                    totalValue > tradingState.balance) {
                                  setState(
                                    () => _validationError = AppStrings
                                        .orderValueExceedsWalletBalance,
                                  );
                                  return;
                                }

                                if (_orderType == OrderType.sell &&
                                    enteredQty > holding.quantity) {
                                  setState(
                                    () => _validationError = AppStrings
                                        .youDonNotOwnEnoughQuantityToSell,
                                  );
                                  return;
                                }

                                // Submit execution
                                BlocProvider.of<TradingBloc>(context).add(
                                  SubmitOrderEvent(
                                    symbol: widget.symbol,
                                    type: _orderType,
                                    quantity: enteredQty,
                                    ltp: ltp,
                                  ),
                                );
                              },
                        child: tradingState.isSubmitting
                            ? Loader()
                            : Text(
                                '${_orderType == OrderType.buy ? AppStrings.buy : AppStrings.sell} ${widget.symbol}',
                                style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                      ),
                    ),
                    24.toSpace(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
