import 'dart:async';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recurring_alarm/domain/entities/reminder.dart';
import 'package:recurring_alarm/domain/notification_services.dart';
import 'package:recurring_alarm/domain/usecases/reminder_usecase.dart';
import 'package:recurring_alarm/routing/app_routes.dart';
import 'package:recurring_alarm/theme/custom_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationServices.initializeNotification();
  initializeService();

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

/// BACKGROUND SERVICE TO KEEP REMINDERS UP TO DATE.

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  // initialize awesome notifications

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: updateRemindersInBackground,
      autoStart: true,
      autoStartOnBoot: true,
      isForegroundMode: true,
      initialNotificationTitle: "Recurring alarm service",
      initialNotificationContent: "Initializing",
    ),
    iosConfiguration: IosConfiguration(),
  );
}

@pragma('vm:entry-point')
Future<void> updateRemindersInBackground(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    Timer.periodic(
      const Duration(hours: 8),
      (timer) async {
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
      },
    );
  }
}
