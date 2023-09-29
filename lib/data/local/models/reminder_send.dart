import 'package:flutter/material.dart';

@immutable
class ReminderSend {
  final String uuid;
  final int reminderEnable;
  final String createAt;
  final String description;
  final String time;
  final String days;
  final String beginDate;
  final List<String> remindersDate;
  final int lenghtBetweenReminder;
  final int reminderType;
  final int whenInMonth;

  const ReminderSend({
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
}
