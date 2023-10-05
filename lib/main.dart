import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recurring_alarm/routing/app_routes.dart';
import 'package:recurring_alarm/theme/custom_theme.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:awesome_notifications/awesome_notifications.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routerConfig: router, theme: CustomTheme.lightTheme(context));
  }
}
