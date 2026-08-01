import 'package:trade_app/exports/exports.dart';
import 'package:trade_app/presentation/widgets/app_button.dart';

class NoStocksView extends StatelessWidget {
  const NoStocksView({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.show_chart, size: 64, color: Colors.grey[400]),
          16.toSpace(),
          const Text(
            AppStrings.yourWatchListIsEmpty,
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
          16.toSpace(),
          AppButton(title: AppStrings.addStocks, onPressed: onPressed),
        ],
      ),
    );
  }
}
