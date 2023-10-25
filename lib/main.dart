import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recurring_alarm/presentation/settings/viewmodel/settings_viewmodel.dart';
import 'package:recurring_alarm/services/notification_services.dart';
import 'package:recurring_alarm/routing/app_routes.dart';
import 'package:recurring_alarm/services/background_services.dart';
import 'package:recurring_alarm/theme/custom_theme.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const updateremindersTask = "service.updatereminders.simplePeriodicTask";
const tomorrowRemindersTask = "service.remindersfortomorrow.simplePeriodicTask";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    if (taskName == updateremindersTask) {
      try {
        await BackgroundService().updateReminders();
      } catch (err) {
        throw Exception(err);
      }
    }

    if (taskName == tomorrowRemindersTask) {
      try {
        await BackgroundService().numbersRemindersToTomorrow();
      } catch (err) {
        throw Exception(err);
      }
    }

    return Future.value(true);
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationServices.initializeNotification();

  initWorkManager();

  runApp(const ProviderScope(child: MainApp()));

  await AwesomeNotifications().isNotificationAllowed().then(
    (isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    },
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('fr'),
        ],
        routerConfig: router,
        themeMode: ref.watch(settingViewModel).darkMode.value
            ? ThemeMode.dark
            : ThemeMode.light,
        darkTheme: CustomTheme.darkTheme(context),
        theme: CustomTheme.lightTheme(context));
  }
}

void initWorkManager() async {
  Workmanager()
      .initialize(callbackDispatcher, isInDebugMode: false)
      .then((_) async {
    await Workmanager().registerPeriodicTask(
      "UpdateReminders",
      updateremindersTask,
      frequency: const Duration(hours: 3),
    );
    await Workmanager().registerPeriodicTask(
      "TomorrowReminders",
      tomorrowRemindersTask,
      frequency: const Duration(hours: 8),
    );
  });
}
