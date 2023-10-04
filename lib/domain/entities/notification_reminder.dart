import 'package:flutter/material.dart';

class NotificationReminder {
  final String uuid;
  final DateTime date;
  final TimeOfDay time;

  NotificationReminder(
      {required this.uuid, required this.date, required this.time});
}
