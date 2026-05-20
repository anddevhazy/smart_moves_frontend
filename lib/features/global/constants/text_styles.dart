import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

abstract class AppTextStyles {
  // ── Display (Balance amounts, hero nums) ──
  static TextStyle get display => GoogleFonts.syne(
        fontSize: 40.sp,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.8,
        color: AppColors.ink100,
        height: 1.1,
      );

  // ── Headline L (Onboarding, splash) ──────
  static TextStyle get headlineLarge => GoogleFonts.syne(
        fontSize: 30.sp,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.3,
        color: AppColors.ink100,
        height: 1.2,
      );

  // ── Headline M (Section titles, cards) ───
  static TextStyle get headlineMedium => GoogleFonts.syne(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.ink100,
        height: 1.3,
      );

  // ── Label (Uppercase field labels) ───────
  static TextStyle get label => GoogleFonts.syne(
        fontSize: 11.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.9,
        color: AppColors.ink40,
      );

  // ── Body (Paragraphs, descriptions) ──────
  static TextStyle get body => GoogleFonts.dmSans(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.ink60,
        height: 1.6,
      );

  // ── UI Text (List items, nav) ─────────────
  static TextStyle get uiMedium => GoogleFonts.dmSans(
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.ink100,
        height: 1.4,
      );

  static TextStyle get uiSmall => GoogleFonts.dmSans(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.ink40,
        height: 1.4,
      );

  // ── Caption (Timestamps, metadata) ───────
  static TextStyle get caption => GoogleFonts.dmSans(
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.ink40,
        letterSpacing: 0.4,
      );

  // ── Amount / Numeric (Syne for money) ────
  static TextStyle get amountLarge => GoogleFonts.syne(
        fontSize: 32.sp,
        fontWeight: FontWeight.w800,
        color: Colors.white,
        letterSpacing: -0.64,
      );

  static TextStyle get amountMedium => GoogleFonts.syne(
        fontSize: 22.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.primary,
        letterSpacing: -0.2,
      );
}
