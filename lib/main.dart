import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recurring_alarm/domain/notification_services.dart';
import 'package:recurring_alarm/domain/usecases/reminder_usecase.dart';
import 'package:recurring_alarm/routing/app_routes.dart';
import 'package:recurring_alarm/theme/custom_theme.dart';
import 'package:workmanager/workmanager.dart';

const simplePeriodicTask = "service.updatereminders.simplePeriodicTask";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    try {
      //add code execution
      debugPrint("Task");

      final container = ProviderContainer();
      final reminderUsecase = container.read(reminderUsecaseProvider);

      await reminderUsecase.updatesReminders();
      container.dispose();
    } catch (err) {
      debugPrint(err.toString());
      throw Exception(err);
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

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routerConfig: router, theme: CustomTheme.lightTheme(context));
  }
}

void initWorkManager() async {
  try {
    print('iniside try,,,,,,,,,,,catch workmanager block');
    Workmanager()
        .initialize(callbackDispatcher, isInDebugMode: true)
        .then((_) async {
      await Workmanager().registerPeriodicTask(
        simplePeriodicTask,
        simplePeriodicTask,
        initialDelay: const Duration(seconds: 10),
      );
    });
  } catch (e) {
    print('Exception in register work manager');
  }
}
