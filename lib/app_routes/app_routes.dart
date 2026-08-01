import 'package:trade_app/exports/exports.dart';

class AppRoutes {
  /// Routes name
  static const String initialRoute = '/';
  static const String signIn = '/sign_in';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;
    // print(args);

    switch (settings.name) {
      case initialRoute:
        return SlideRightRoute(settings: settings, page: const SplashScreen());
      case signIn:
        return SlideRightRoute(settings: settings, page: const SplashScreen());
      default:
        return SlideRightRoute(settings: settings, page: const SplashScreen());
    }
  }
}
