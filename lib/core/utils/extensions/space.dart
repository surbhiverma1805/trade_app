import 'package:trade_app/exports/exports.dart';

/// Extension for space
extension Space on int {
  Widget toSpace({bool horizontally = true, bool vertically = true}) {
    assert(horizontally != false || vertically != false);
    return SizedBox(
      width: horizontally ? toDouble().w : 0,
      height: vertically ? toDouble().w : 0,
    );
  }

  Widget get height => SizedBox(height: toDouble());

  Widget get width => SizedBox(width: toDouble());
}
