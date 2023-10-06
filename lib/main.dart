import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recurring_alarm/domain/entities/reminder.dart';
import 'package:recurring_alarm/domain/notification_services.dart';
import 'package:recurring_alarm/domain/usecases/reminder_usecase.dart';
import 'package:recurring_alarm/routing/app_routes.dart';
import 'package:recurring_alarm/theme/custom_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().registerPeriodicTask(
    "task-identifier",
    "simpleTask",
    // When no frequency is provided the default 15 minutes is set.
    // Minimum frequency is 15 min. Android will automatically change your frequency to 15 min if you have configured a lower frequency.

    frequency: const Duration(hours: 1),
  );

  Workmanager().executeTask((task, inputData) async {
    try {
      //add code execution
      debugPrint("Task");

      final container = ProviderContainer();
      final reminderUsecase = container.read(reminderUsecaseProvider);

      final currentTime = DateTime.now();
      final reminders = await reminderUsecase.fetchAllReminders();
      final remindersToUpdate = <Reminder>[];
      for (var reminder in reminders) {
        if (reminder.remindersDate != null) {
          bool allDatesPassed = false;
          for (var i = 0; i < reminder.remindersDate!.length; i++) {
            if (reminder.remindersDate![i].isBefore(currentTime)) {
              allDatesPassed = true;
              break;
            }
          }

          if (allDatesPassed) {
            remindersToUpdate.add(reminder);
          }
        }
      }
      for (var reminderToUpdate in remindersToUpdate) {
        await reminderUsecase.updateReminder(reminderToUpdate);
      }

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

  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  Workmanager().registerOneOffTask("task-identifier", "simpleTask");

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
