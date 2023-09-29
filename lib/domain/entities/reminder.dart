import 'package:flutter/material.dart';
import 'package:recurring_alarm/core/constant.dart';
import 'package:recurring_alarm/data/local/models/reminder_send.dart';

@immutable
class Reminder {
  final String uuid;
  final bool reminderEnable;
  final DateTime createAt;
  final String description;
  final TimeOfDay time;
  final Set<SelectedDay> days;
  final DateTime beginDate;
  final List<DateTime> remindersDate;
  final int lenghtBetweenReminder;
  final int reminderType;
  final int whenInMonth;

  const Reminder({
    required this.description,
    required this.beginDate,
    required this.reminderType,
    required this.lenghtBetweenReminder,
    required this.days,
    required this.whenInMonth,
    required this.remindersDate,
    required this.time,
    required this.uuid,
    required this.createAt,
    required this.reminderEnable,
  });

  // Transform Reminder to a ReminderSend for give to a Database

  ReminderSend fromEntity() {
    return ReminderSend(
        description: description,
        beginDate: beginDate.toString(),
        reminderType: reminderType,
        lenghtBetweenReminder: lenghtBetweenReminder,
        days: days.toString(),
        whenInMonth: whenInMonth,
        remindersDate: remindersDate.map((e) => e.toString()).toList(),
        time: time.toString(),
        uuid: uuid,
        createAt: createAt.toString(),
        reminderEnable: reminderEnable == false ? 0 : 1);
  }
}
