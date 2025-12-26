import 'dart:ui';

abstract class AppColors {
  static const greyScale = _GreyScale();
  static const Color white = Color(0xffffffff);
  static const Color green = Color(0xff16A34A);
  static const Color greenFade = Color(0xffF0FDF4);
  static const Color darkBlue = Color(0xff111827);
  static const Color cardBackground = Color(0xffF9FAFB);
  static const Color red = Color(0xffDC2626);
  static const Color yellow = Color(0xffFFEB3B);
}

class _GreyScale {
  const _GreyScale();

  final Color grey900 = const Color(0xFF212121);
  final Color grey800 = const Color(0xFF424242);
  final Color grey700 = const Color(0xFF616161);
  final Color grey600 = const Color(0xFF757575);
  final Color grey500 = const Color(0xFF9E9E9E);
  final Color grey400 = const Color(0xFFBDBDBD);
  final Color grey300 = const Color(0xFFE0E0E0);
  final Color grey200 = const Color(0xFFEEEEEE);
  final Color grey100 = const Color(0xFFF5F5F5);
  final Color grey50 = const Color(0xFFFAFAFA);
}
