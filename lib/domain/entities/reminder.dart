import 'package:flutter/material.dart';
import 'package:recurring_alarm/core/constant.dart';
import 'package:recurring_alarm/data/local/models/reminder_send.dart';

@immutable
class Reminder {
  final int uuid;
  final bool reminderEnable;
  final DateTime createAt;
  final String description;
  final TimeOfDay time;
  final List<int> days;
  final DateTime beginDate;
  final List<DateTime>? remindersDate;
  final int lenghtBetweenReminder;
  final ReminderType reminderType;
  final SelectedWhenInMonth whenInMonth;

  const Reminder({
    required this.description,
    required this.beginDate,
    required this.reminderType,
    required this.lenghtBetweenReminder,
    required this.days,
    required this.whenInMonth,
    this.remindersDate,
    required this.time,
    required this.uuid,
    required this.createAt,
    required this.reminderEnable,
  });

  Reminder toggleSelected() {
    return Reminder(
        description: description,
        beginDate: beginDate,
        whenInMonth: whenInMonth,
        time: time,
        remindersDate: remindersDate,
        reminderType: reminderType,
        days: days,
        lenghtBetweenReminder: lenghtBetweenReminder,
        reminderEnable: !reminderEnable,
        uuid: uuid,
        createAt: createAt);
  }

  // Transform Reminder to a ReminderSend for give to a Database

  ReminderSend fromEntity() {
    return ReminderSend(
        description: description,
        beginDate: beginDate.toString(),
        reminderType: reminderType.index,
        lenghtBetweenReminder: lenghtBetweenReminder,
        days:
            days.toString().replaceAll("[", "").replaceAll("]", "").toString(),
        whenInMonth: whenInMonth.index,
        remindersDate:
            remindersDate!.map((date) => date.toIso8601String()).join(","),
        time: "${time.hour}:${time.minute}",
        uuid: uuid,
        createAt: createAt.toIso8601String(),
        reminderEnable: reminderEnable == false ? 0 : 1);
  }

  // used to calculate the next reminders dates before seeding to database

  Reminder.withCalculatedDates(
      Reminder original, List<DateTime> calculatedDates)
      : description = original.description,
        beginDate = original.beginDate,
        createAt = original.createAt,
        days = original.days,
        lenghtBetweenReminder = original.lenghtBetweenReminder,
        reminderEnable = original.reminderEnable,
        reminderType = original.reminderType,
        remindersDate = calculatedDates,
        time = original.time,
        uuid = original.uuid,
        whenInMonth = original.whenInMonth;
}
