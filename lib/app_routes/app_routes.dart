import 'package:trade_app/exports/exports.dart';

class AppRoutes {
  /// Routes name
  static const String initialRoute = '/';
  static const String dashboard = '/dashboard_screen';
  static const String watchlist = '/watchlist';
  static const String marketOverview = '/market_overview';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;
    // print(args);

    switch (settings.name) {
      case initialRoute:
        return SlideRightRoute(settings: settings, page: const SplashScreen());
      case dashboard:
        return SlideRightRoute(
          settings: settings,
          page: const DashboardScreen(),
        );
      case watchlist:
        return SlideRightRoute(
          settings: settings,
          page: const WatchlistScreen(),
        );
      case marketOverview:
        return SlideRightRoute(
          settings: settings,
          page: const MarketOverviewScreen(),
        );
      default:
        return SlideRightRoute(settings: settings, page: const SplashScreen());
    }
  }
}
