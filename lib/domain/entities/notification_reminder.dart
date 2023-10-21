import 'package:flutter/material.dart';

@immutable
class NotificationReminder {
  final int uuid;
  final String task;
  final DateTime date;

  const NotificationReminder(
      {required this.uuid, required this.task, required this.date});
}
