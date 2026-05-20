import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_moves/features/global/constants/colors.dart';
import 'package:smart_moves/features/global/core/config/flavor_config.dart';
import 'package:smart_moves/features/global/routes/routes.dart';
import 'package:smart_moves/firebase_options.dart';
import 'main_injection_container.dart' as di;

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Disabling Crashlytics in dev so test crashes don't dirty my dashboard
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
    !FlavorConfig.instance.isDev,
  );

  // Catching Flutter framework errors (widget build errors, etc.)
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Catching async errors outside Flutter framework (Future errors, isolate errors)
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Smart Moves',
          debugShowCheckedModeBanner: false,
          routerConfig: Routes.router,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
              primary: AppColors.primary,
            ),
            textTheme: GoogleFonts.dmSansTextTheme(),
            scaffoldBackgroundColor: AppColors.ink02,
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              },
            ),
          ),
        );
      },
    );
  }
}
