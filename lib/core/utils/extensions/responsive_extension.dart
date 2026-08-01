import 'package:trade_app/exports/exports.dart';

/// Used for font size, height and width scaling
class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;

  // Base design dimensions
  static const double designWidth = 375.0;
  static const double designHeight = 812.0;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
  }
}

extension ResponsiveExtension on num {
  /// Responsive width based on design width (375dp)
  double get w => (this / SizeConfig.designWidth) * SizeConfig.screenWidth;

  /// Responsive height based on design height (812dp)
  double get h => (this / SizeConfig.designHeight) * SizeConfig.screenHeight;

  /// Responsive font size scaling
  double get sp => (this / SizeConfig.designWidth) * SizeConfig.screenWidth;
}
