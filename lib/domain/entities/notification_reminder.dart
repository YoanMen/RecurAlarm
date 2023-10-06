import 'package:flutter/material.dart';

class NotificationReminder {
  final int uuid;
  final String task;
  final DateTime date;
  final TimeOfDay time;

  NotificationReminder(
      {required this.uuid,
      required this.task,
      required this.date,
      required this.time});
}
