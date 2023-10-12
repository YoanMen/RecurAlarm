import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recurring_alarm/core/failure.dart';
import 'package:recurring_alarm/data/local/local_database.dart';
import 'package:recurring_alarm/domain/entities/reminder.dart';
import 'package:recurring_alarm/services/notification_services.dart';
import 'package:recurring_alarm/domain/usecases/reminder_usecase.dart';
import 'package:recurring_alarm/routing/app_routes.dart';
import 'package:recurring_alarm/theme/custom_theme.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const simplePeriodicTask = "service.updatereminders.simplePeriodicTask";

Future _updatesReminders() async {
  debugPrint("Update remindersdzdzd");
  ReminderUsecase useCase = ReminderUsecase(SqlfLite());

  final currentTime = DateTime.now();
  final reminders = await useCase.fetchAllReminders();
  final remindersToUpdate = <Reminder>[];

  for (var reminder in reminders) {
    if (reminder.remindersDate != null) {
      bool needUpdate = false;
      for (var i = 0; i < reminder.remindersDate!.length; i++) {
        debugPrint(reminder.remindersDate![i].toString());
        if (reminder.remindersDate![i].isBefore(currentTime)) {
          needUpdate = true;
          break;
        }
      }

      if (needUpdate) {
        remindersToUpdate.add(reminder);
      }
    }
  }
  for (var reminderToUpdate in remindersToUpdate) {
    await useCase.updateReminder(reminderToUpdate);

    try {
      List<DateTime> calculatedDates = [
        DateTime.now().add(const Duration(seconds: 10))
      ];
      Reminder reminder =
          Reminder.withCalculatedDates(reminderToUpdate, calculatedDates);

      final reminderSend = reminder.fromEntity();
      await SqlfLite().updateReminder(reminderSend);
      await useCase.manageNotification(reminder);

      debugPrint("${remindersToUpdate.length} Reminders updates");
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    try {
      //add code execution
      debugPrint(" _____Task_______ ");

      await _updatesReminders();
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
    return MaterialApp.router(localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ], supportedLocales: const [
      Locale('en'),
      Locale('fr'),
    ], routerConfig: router, theme: CustomTheme.lightTheme(context));
  }
}

void initWorkManager() async {
  Workmanager()
      .initialize(callbackDispatcher, isInDebugMode: false)
      .then((_) async {
    await Workmanager().registerPeriodicTask(
      "UpdateReminders",
      simplePeriodicTask,
      frequency: const Duration(hours: 3),
    );
  });
}
