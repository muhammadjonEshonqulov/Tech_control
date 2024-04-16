import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_control/ui/additions.dart';
import 'package:tech_control/ui/login.dart';
import 'package:tech_control/ui/splash.dart';

import '../ui/qr_scanner.dart';

abstract final class Routes {
  static const splash = '/nav_splash';
  static const login = '/nav_login';
  static const qr_scan = '/nav_qr_scan';
  static const additional = '/nav_additional';

  static const baseUrl = "$baseUrlImage/v2/api/";
  static const baseUrlImage = "https://back.eavtotalim.uz";
}

final router = GoRouter(
  initialLocation: Routes.splash,
  routes: [
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: Routes.qr_scan,
      builder: (context, state) => const QRViewExample(),
    ),
    GoRoute(
      path: Routes.additional,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final id = extra['id'] ?? "";
        return AdditionScreen(id: id);
      },
    ),
  ],
);

void finish(BuildContext context) {
  Navigator.of(context).pop();
}
