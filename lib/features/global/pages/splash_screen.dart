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
      // backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          const Positioned.fill(child: _ConcentricRings()),
          const Positioned(top: 80, right: 24, child: _DotGrid()),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          AppAssets.appIcon,
                          width: 84.r,
                          height: 84.r,
                        ),
                        SizedBox(height: 20.r),
                        // Text(
                        //   'SmartMoves',
                        //   style: GoogleFonts.syne(
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.w800,
                        //     color: Colors.white,
                        //     letterSpacing: -0.5,
                        //     height: 1.2,
                        //   ),
                        // ),
                        // Text(
                        //   'SmartMoves',
                        //   style: GoogleFonts.syne(
                        //     fontSize: 32,
                        //     fontWeight: FontWeight.w700,
                        //     color: Colors.white,
                        //     letterSpacing: -2,
                        //   ),
                        // ),
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
                        // const Text(
                        //   'SmartMoves',
                        //   style: TextStyle(
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.w800,
                        //     color: Colors.white,
                        //   ),
                        // ),
                        // SizedBox(height: 2.r),
                        // Text(
                        //   'BUDGET SMART. LIVE FREE.',
                        //   style: GoogleFonts.syne(
                        //     fontSize: 11,
                        //     fontWeight: FontWeight.w600,
                        //     color: Colors.white.withValues(alpha: 0.50),
                        //     letterSpacing: 2.2,
                        //   ),
                        // ),
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

// ── Concentric rings ──────────────────────────────────────────────────────────

class _ConcentricRings extends StatelessWidget {
  const _ConcentricRings();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _RingsPainter());
  }
}

class _RingsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.07)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final center = Offset(size.width * 0.5, size.height * 0.5);
    for (final r in [100.0, 170.0, 240.0, 310.0, 380.0]) {
      canvas.drawCircle(center, r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}

// ── Dot grid ──────────────────────────────────────────────────────────────────

class _DotGrid extends StatelessWidget {
  const _DotGrid();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: const Size(88, 72), painter: _DotGridPainter());
  }
}

class _DotGridPainter extends CustomPainter {
  static const _lit = {(1, 0), (3, 0), (0, 1), (4, 2), (2, 3), (1, 2)};

  @override
  void paint(Canvas canvas, Size size) {
    const cols = 5;
    const rows = 4;
    const spacing = 16.0;
    const dotR = 2.0;

    for (var c = 0; c < cols; c++) {
      for (var r = 0; r < rows; r++) {
        final isLit = _lit.contains((c, r));
        canvas.drawCircle(
          Offset(c * spacing + spacing * 0.5, r * spacing + spacing * 0.5),
          dotR,
          Paint()
            ..color = Colors.white.withValues(alpha: isLit ? 0.75 : 0.18)
            ..style = PaintingStyle.fill,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
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
