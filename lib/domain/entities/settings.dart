import 'package:flutter/material.dart';

@immutable
class Settings {
  final bool notifiedTomorrow;
  final bool darkMode;
  final bool alarmMode;

  const Settings(
      {required this.notifiedTomorrow,
      required this.darkMode,
      required this.alarmMode});
}
