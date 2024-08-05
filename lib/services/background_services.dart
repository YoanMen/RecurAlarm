import 'package:intl/date_symbol_data_local.dart';
import 'package:recurring_alarm/core/failure.dart';
import 'package:recurring_alarm/data/local/local_database.dart';
import 'package:recurring_alarm/domain/entities/reminder.dart';
import 'package:recurring_alarm/domain/reminder_calculator.dart';
import 'package:recurring_alarm/domain/usecases/reminder_usecase.dart';
import 'package:recurring_alarm/services/notification_services.dart';

class BackgroundService {
  Future updateReminders() async {
    // initialize
    initializeDateFormatting();
    await NotificationServices.initializeNotification();

    ReminderUsecase useCase = ReminderUsecase(SqlfLite());

    final currentTime = DateTime.now();

    // fetch reminders
    final reminders = await useCase.fetchAllReminders();
    final remindersToUpdate = <Reminder>[];

    // check if reminders need update
    for (var reminder in reminders) {
      if (reminder.remindersDate != null) {
        bool needUpdate = false;
        for (var i = 0; i < reminder.remindersDate!.length; i++) {
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

    if (remindersToUpdate.isEmpty) return;

    // updates reminders with new calculated dates

    for (var reminderToUpdate in remindersToUpdate) {
      try {
        List<DateTime> calculatedDates =
            await calculateNextReminder(reminderToUpdate);

        Reminder reminder =
            Reminder.withCalculatedDates(reminderToUpdate, calculatedDates);

        final reminderSend = reminder.fromEntity();
        await SqlfLite().updateReminder(reminderSend);
        await useCase.manageNotification(reminder);
      } catch (e) {
        throw Failure(message: e.toString());
      }
    }
  }
}
