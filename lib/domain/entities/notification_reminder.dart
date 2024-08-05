// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

@immutable
class NotificationReminder {
  final int uuid;
  final String task;
  final DateTime date;

  const NotificationReminder(
      {required this.uuid, required this.task, required this.date});

  @override
  String toString() =>
      'NotificationReminder(uuid: $uuid, task: $task, date: $date)';

  @override
  bool operator ==(covariant NotificationReminder other) {
    if (identical(this, other)) return true;

    return other.uuid == uuid && other.task == task && other.date == date;
  }

  @override
  int get hashCode => uuid.hashCode ^ task.hashCode ^ date.hashCode;
}
