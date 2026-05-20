import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSpacing {
  // ── Core scale ───────────────────────────
  static double get xs2 => 2.r; // Icon gap, tight chips
  static double get xs => 4.r; // Badge padding, dot spacing
  static double get sm => 8.r; // Chip gaps, inner cell gap
  static double get md => 12.r; // Card row padding, list item gap
  static double get lg => 16.r; // Horizontal screen margin
  static double get xl => 20.r; // Card padding
  static double get xl2 => 24.r; // Section gap
  static double get xl3 => 32.r; // Major section separation
  static double get xl4 => 48.r; // Top padding on splash screens

  // ── Screen margins ────────────────────────
  static EdgeInsets get screenPadding =>
      EdgeInsets.symmetric(horizontal: lg, vertical: md);

  static EdgeInsets get screenPaddingH => EdgeInsets.symmetric(horizontal: lg);

  // ── Component-level shortcuts ─────────────
  static EdgeInsets get cardPadding => EdgeInsets.all(xl);

  static EdgeInsets get listItemPadding =>
      EdgeInsets.symmetric(horizontal: lg, vertical: md);

  static EdgeInsets get chipPadding =>
      EdgeInsets.symmetric(horizontal: md, vertical: xs);

  static EdgeInsets get buttonPadding =>
      EdgeInsets.symmetric(horizontal: xl2, vertical: lg);

  // ── Bottom nav ───────────────────────────
  static double get bottomNavHeight => 64.r;
  static double get bottomNavBottomPad => 16.r;
}
