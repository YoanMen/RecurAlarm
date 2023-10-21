import 'package:flutter/material.dart';
import 'package:recurring_alarm/domain/entities/bool_setting.dart';

@immutable
class Settings {
  final BoolSetting notifiedTomorrow;
  final BoolSetting darkMode;
  final BoolSetting alarmMode;

  const Settings(
      {required this.notifiedTomorrow,
      required this.darkMode,
      required this.alarmMode});
}
