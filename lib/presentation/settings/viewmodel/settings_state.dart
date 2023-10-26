// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:recurring_alarm/domain/entities/bool_setting.dart';

@immutable
class SettingState {
  final BoolSetting notifiedTomorrow;
  final BoolSetting darkMode;
  final BoolSetting alarmMode;
  final BoolSetting vibrate;

  const SettingState(
      {required this.notifiedTomorrow,
      required this.darkMode,
      required this.alarmMode,
      required this.vibrate});

  SettingState copyWith({
    BoolSetting? notifiedTomorrow,
    BoolSetting? darkMode,
    BoolSetting? alarmMode,
    BoolSetting? vibrate,
  }) {
    return SettingState(
      notifiedTomorrow: notifiedTomorrow ?? this.notifiedTomorrow,
      darkMode: darkMode ?? this.darkMode,
      alarmMode: alarmMode ?? this.alarmMode,
      vibrate: vibrate ?? this.vibrate,
    );
  }
}
