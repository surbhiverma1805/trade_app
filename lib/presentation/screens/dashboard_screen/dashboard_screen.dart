import 'package:trade_app/exports/exports.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  // List of screens corresponding features (add more as you build them)
  final List<Widget> _screens = [
    const WatchlistScreen(), // Feature 1: Watchlists
    const MarketOverviewScreen(), // Feature 2: Live Prices Mimic
    const PortfolioScreen(), // Feature 3: Portfolio of sell/buy
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens, // IndexedStack preserves state when switching tabs!
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          border: Border(
            top: BorderSide(color: AppColors.white100Color, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() => _currentIndex = index);

            // If the user taps the Portfolio tab (index 2), force a fresh reload
            if (index == 2) {
              context.read<TradingBloc>().add(LoadTradingAccountEvent());
            }
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.whiteColor,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.slateGreyColor,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12.sp,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_rounded),
              label: AppStrings.watchlist,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.show_chart_rounded),
              label: AppStrings.markets,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart_outline_rounded),
              label: AppStrings.portfolio,
            ),
          ],
        ),
      ),
    );
  }
}
