import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_moves/features/global/constants/assets.dart';

import '../constants/colors.dart';
import '../constants/radius.dart';
import '../constants/spacing.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.65,
              child: Image.asset(AppAssets.splashHero, fit: BoxFit.cover),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.35),
                    Colors.black.withValues(alpha: 0.10),
                    Colors.black.withValues(alpha: 0.55),
                  ],
                  stops: const [0.0, 0.45, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            top: 350.r, // ← adjust this value to move the icon up/down
            left: 0,
            right: 0,
            child: Center(
              child: SvgPicture.asset(
                AppAssets.appIcon,
                width: 73.r,
                height: 73.r,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 84.r + 52.r),
                        Transform.scale(
                          scaleX: 0.7,
                          scaleY: 1.4,
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            'SmartMoves',
                            style: GoogleFonts.syne(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              // letterSpacing: -2,
                            ),
                          ),
                        ),

                        Transform.scale(
                          scaleX: 0.8,
                          scaleY: 1.2,
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            'BUDGET SMART. LIVE FREE.',
                            style: GoogleFonts.syne(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.white.withValues(alpha: 0.50),
                              letterSpacing: 2.2, // letterSpacing: -2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const _LoadingBar(),
                SizedBox(height: 10.r),
                Text(
                  'Loading your finances...',
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.45),
                  ),
                ),
                SizedBox(height: 32.r),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Loading bar ───────────────────────────────────────────────────────────────

class _LoadingBar extends StatefulWidget {
  const _LoadingBar();

  @override
  State<_LoadingBar> createState() => _LoadingBarState();
}

class _LoadingBarState extends State<_LoadingBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..forward();
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.screenPaddingH,
      child: AnimatedBuilder(
        animation: _anim,
        builder: (context, _) => Container(
          height: 3.r,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.20),
            borderRadius: AppRadius.bFull,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: _anim.value,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: AppRadius.bFull,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
