// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:recurring_alarm/core/common/formatting_utils.dart';
import 'package:recurring_alarm/core/constant.dart';
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
  final String remindersDate;
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

  // used to convert response to reminder
  Reminder toEntity() {
    return Reminder(
        description: description,
        beginDate: formatDate(beginDate),
        reminderType: ReminderType.values[reminderType],
        lenghtBetweenReminder: lenghtBetweenReminder,
        days: days.split(",").toList().map((e) => int.parse(e)).toList(),
        whenInMonth: SelectedWhenInMonth.values[whenInMonth],
        remindersDate: formatMultipleDates(remindersDate.split(",")),
        time: formatTime(time),
        uuid: int.parse(uuid),
        createAt: formatDate(createAt),
        reminderEnable: reminderEnable == 0 ? false : true);
  }

  // get data for database
  factory ReminderResponse.fromMap(Map<String, dynamic> map) {
    return ReminderResponse(
      uuid: map['uuid'],
      reminderEnable: map['reminder_enable'],
      createAt: map['create_at'],
      description: map['description'],
      time: map['time'],
      days: map['days'],
      beginDate: map['begin_date'],
      remindersDate: map['reminders_date'],
      lenghtBetweenReminder: map['lenght_between_reminder'],
      reminderType: map['reminder_type'],
      whenInMonth: map['when_in_month'],
    );
  }

  @override
  String toString() {
    return 'ReminderResponse(uuid: $uuid, reminderEnable: $reminderEnable, createAt: $createAt, description: $description, time: $time, days: $days, beginDate: $beginDate, remindersDate: $remindersDate, lenghtBetweenReminder: $lenghtBetweenReminder, reminderType: $reminderType, whenInMonth: $whenInMonth)';
  }

  @override
  bool operator ==(covariant ReminderResponse other) {
    if (identical(this, other)) return true;

    return other.uuid == uuid &&
        other.reminderEnable == reminderEnable &&
        other.createAt == createAt &&
        other.description == description &&
        other.time == time &&
        other.days == days &&
        other.beginDate == beginDate &&
        other.remindersDate == remindersDate &&
        other.lenghtBetweenReminder == lenghtBetweenReminder &&
        other.reminderType == reminderType &&
        other.whenInMonth == whenInMonth;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        reminderEnable.hashCode ^
        createAt.hashCode ^
        description.hashCode ^
        time.hashCode ^
        days.hashCode ^
        beginDate.hashCode ^
        remindersDate.hashCode ^
        lenghtBetweenReminder.hashCode ^
        reminderType.hashCode ^
        whenInMonth.hashCode;
  }
}
