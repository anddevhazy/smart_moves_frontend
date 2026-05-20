import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_moves/features/global/pages/splash_screen.dart';

class ProfileArgs {
  final String email;
  final String? name;
  final String? matricNumber;
  final String? level;
  final String? department;
  final VoidCallback onLogout;
  final VoidCallback onDeleteAccount;

  const ProfileArgs({
    required this.email,
    this.name,
    this.matricNumber,
    this.level,
    this.department,
    required this.onLogout,
    required this.onDeleteAccount,
  });
}

class Routes {
  static const String splashPath = '/splash';
  static const String splashName = 'splash';

  static const String lecturerHistoryPath = '/lecturerHistory';
  static const String lecturerHistoryName = 'lecturerHistory';

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,

    initialLocation: splashPath,
    routes: [
      GoRoute(
        path: splashPath,
        name: splashName,
        builder: (context, state) => const SplashScreen(),
      ),
      // GoRoute(
      //   path: lecturerHistoryPath,
      //   name: lecturerHistoryName,
      //   builder: (context, state) => const LecturerHistoryPage(),
      // ),

      // ShellRoute(
      //   navigatorKey: shellNavigatorKey,
      //   builder:
      //       (context, state, child) =>
      //           MainScreen(routeState: state, child: child),
      //   routes: [
      //     GoRoute(
      //       path: studentHomePath,
      //       name: studentHomeName,
      //       builder: (context, state) => const StudentHomePage(),
      //     ),
      //     GoRoute(
      //       path: lecturerHomePath,
      //       name: lecturerHomeName,
      //       builder: (context, state) => const LecturerHomePage(),
      //     ),
      //     GoRoute(
      //       path: settingsPath,
      //       name: settingsName,
      //       builder: (context, state) => const SettingsPage(),
      //     ),
      //   ],
      // ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text(state.error.toString()))),
  );
}
