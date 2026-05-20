import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppRadius {
  // ── Named tokens ─────────────────────────
  static double get xs => 4.r; // Progress bars, dividers
  static double get sm => 8.r; // Badges, status pills
  static double get md => 12.r; // Transaction rows, quick btns
  static double get lg => 16.r; // Cards, bottom sheet
  static double get xl => 24.r; // Hero cards, modals
  static const double full = 999.0; // Pills, CTAs, chips

  // ── BorderRadius shortcuts ────────────────
  static BorderRadius get bXs => BorderRadius.circular(xs);
  static BorderRadius get bSm => BorderRadius.circular(sm);
  static BorderRadius get bMd => BorderRadius.circular(md);
  static BorderRadius get bLg => BorderRadius.circular(lg);
  static BorderRadius get bXl => BorderRadius.circular(xl);
  static BorderRadius get bFull => BorderRadius.circular(full);

  // ── Bottom sheet / drawer ─────────────────
  static BorderRadius get bottomSheet => BorderRadius.only(
    topLeft: Radius.circular(xl),
    topRight: Radius.circular(xl),
  );

  // ── Phone frame ───────────────────────────
  static double get phoneFrame => 36.r;
}
