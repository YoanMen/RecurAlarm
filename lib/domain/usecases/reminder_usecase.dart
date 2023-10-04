import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recurring_alarm/core/failure.dart';
import 'package:recurring_alarm/data/local/local_database.dart';
import 'package:recurring_alarm/domain/entities/reminder.dart';
import 'package:recurring_alarm/domain/reminder_calculator.dart';

final reminderUsecaseProvider = Provider<ReminderUsecase>((ref) {
  final localDdb = ref.watch(reminderlocalDdbProvider);

  return ReminderUsecase(localDdb);
});

class ReminderUsecase {
  final LocalDatabase _reminderlocalDdbProvider;
  ReminderUsecase(this._reminderlocalDdbProvider);

  Future<List<Reminder>> fetchAllReminders() async {
    try {
      final response = await _reminderlocalDdbProvider.fetchAllReminders();

      final reminders = response
          .map((reminderResponse) => reminderResponse.toEntity())
          .toList();
      return reminders;
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  Future addReminder(Reminder newReminder) async {
    try {
      List<DateTime> calculatedDates = await calculateNextReminder(newReminder);

      Reminder reminder =
          Reminder.withCalculatedDates(newReminder, calculatedDates);
      final reminderSend = reminder.fromEntity();

      await _reminderlocalDdbProvider.addReminder(reminderSend);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  Future updateReminder(Reminder newReminder) async {
    try {
      List<DateTime> calculatedDates = await calculateNextReminder(newReminder);
      Reminder reminder =
          Reminder.withCalculatedDates(newReminder, calculatedDates);

      final reminderSend = reminder.fromEntity();
      await _reminderlocalDdbProvider.updateReminder(reminderSend);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  Future updateToggleReminder(Reminder reminder) async {
    try {
      final reminderSend = reminder.fromEntity();
      await _reminderlocalDdbProvider.updateReminder(reminderSend);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  Future<List<DateTime>> calculNextReminder(
      {required Reminder reminder}) async {
    List<DateTime> nextReminderList = [];

    try {
      nextReminderList = await calculateNextReminder(reminder);
    } catch (e) {
      throw Failure(message: "Error cant get next reminder date");
    }

    return nextReminderList;
  }

  Future deleteAll() async {
    try {
      await _reminderlocalDdbProvider.deleteAll();
    } catch (e) {
      throw Failure(message: 'can delette');
    }
  }
}
