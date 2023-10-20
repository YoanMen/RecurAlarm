import 'package:flutter/material.dart';

@immutable
class SettingState {
  final bool notifiedTomorrow;
  final bool darkMode;
  final bool alarmMode;

  const SettingState(
      {required this.notifiedTomorrow,
      required this.darkMode,
      required this.alarmMode});
}
