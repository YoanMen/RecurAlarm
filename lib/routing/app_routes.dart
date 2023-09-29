import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recurring_alarm/presentation/reminder/screens/landing/landing_screen.dart';
import 'package:recurring_alarm/presentation/reminder/screens/setting/settings_screen.dart';

enum AppRoute { splash, landing, settings }

final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: "/",
    routes: [
      GoRoute(
        name: AppRoute.landing.name,
        path: "/",
        pageBuilder: (context, state) =>
            const MaterialPage(child: LandingScreen()),
      ),
      GoRoute(
        name: AppRoute.settings.name,
        path: "/settings",
        pageBuilder: (context, state) =>
            const MaterialPage(child: SettingsScreen()),
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: Scaffold(
            body: Center(
              child: Text(state.error.toString()),
            ),
          ),
        ));
