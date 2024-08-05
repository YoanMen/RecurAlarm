// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

@immutable
class ReminderSend {
  final int uuid;
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

  // used to save on the database
  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'reminder_enable': reminderEnable,
      'create_at': createAt,
      'description': description,
      'time': time,
      'days': days,
      'begin_date': beginDate,
      'reminders_date': remindersDate,
      'lenght_between_reminder': lenghtBetweenReminder,
      'reminder_type': reminderType,
      'when_in_month': whenInMonth,
    };
  }

  @override
  String toString() {
    return 'ReminderSend(uuid: $uuid, reminderEnable: $reminderEnable, createAt: $createAt, description: $description, time: $time, days: $days, beginDate: $beginDate, remindersDate: $remindersDate, lenghtBetweenReminder: $lenghtBetweenReminder, reminderType: $reminderType, whenInMonth: $whenInMonth)';
  }

  @override
  bool operator ==(covariant ReminderSend other) {
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
