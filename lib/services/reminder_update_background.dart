import 'package:flutter/material.dart';
import 'package:recurring_alarm/core/failure.dart';
import 'package:recurring_alarm/data/local/local_database.dart';
import 'package:recurring_alarm/domain/entities/reminder.dart';
import 'package:recurring_alarm/domain/reminder_calculator.dart';
import 'package:recurring_alarm/domain/usecases/reminder_usecase.dart';

Future backgroudUpdateReminders() async {
  debugPrint("__Update__");
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
      List<DateTime> calculatedDates =
          await calculateNextReminder(reminderToUpdate);

      Reminder reminder =
          Reminder.withCalculatedDates(reminderToUpdate, calculatedDates);

      final reminderSend = reminder.fromEntity();
      await SqlfLite().updateReminder(reminderSend);
      await useCase.manageNotification(reminder);

      debugPrint(
          "__Background update finished for ${remindersToUpdate.length}");
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
