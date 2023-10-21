// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:recurring_alarm/domain/entities/bool_setting.dart';

@immutable
class SettingState {
  final BoolSetting notifiedTomorrow;
  final BoolSetting darkMode;
  final BoolSetting alarmMode;

  const SettingState(
      {required this.notifiedTomorrow,
      required this.darkMode,
      required this.alarmMode});

  SettingState copyWith({
    BoolSetting? notifiedTomorrow,
    BoolSetting? darkMode,
    BoolSetting? alarmMode,
  }) {
    return SettingState(
      notifiedTomorrow: notifiedTomorrow ?? this.notifiedTomorrow,
      darkMode: darkMode ?? this.darkMode,
      alarmMode: alarmMode ?? this.alarmMode,
    );
  }
}
