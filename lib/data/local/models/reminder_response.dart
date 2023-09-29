// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:recurring_alarm/data/formatting_utils.dart';
import 'package:recurring_alarm/domain/entities/reminder.dart';

@immutable
class ReminderResponse {
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

  const ReminderResponse({
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

  Reminder toEntity() {
    return Reminder(
        description: description,
        beginDate: formatDate(beginDate),
        reminderType: reminderType,
        lenghtBetweenReminder: lenghtBetweenReminder,
        days: formatDaysToSelectedDays(days),
        whenInMonth: whenInMonth,
        remindersDate: formatMultipleDates(remindersDate),
        time: formatTime(time),
        uuid: uuid,
        createAt: formatDate(createAt),
        reminderEnable: reminderEnable == 0 ? false : true);
  }

  factory ReminderResponse.fromMap(Map<String, dynamic> map) {
    return ReminderResponse(
      uuid: map['uuid'] ?? "",
      reminderEnable: map['reminderEnable'] ?? "",
      createAt: map['createAt'] ?? "",
      description: map['description'] ?? "",
      time: map['time'] ?? "",
      days: map['days'] ?? "",
      beginDate: map['beginDate'] ?? "",
      remindersDate: map['remindersDate'] ?? "",
      lenghtBetweenReminder: map['lenghtBetweenReminder'] ?? "",
      reminderType: map['reminderType'] ?? "",
      whenInMonth: map['whenInMonth'] ?? "",
    );
  }
}
