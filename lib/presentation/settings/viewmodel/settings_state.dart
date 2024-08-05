// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:recurring_alarm/domain/entities/bool_setting.dart';

@immutable
class SettingState {
  final BoolSetting darkMode;
  final BoolSetting alarmMode;

  const SettingState({
    required this.darkMode,
    required this.alarmMode,
  });

  SettingState copyWith({
    BoolSetting? darkMode,
    BoolSetting? alarmMode,
  }) {
    return SettingState(
      darkMode: darkMode ?? this.darkMode,
      alarmMode: alarmMode ?? this.alarmMode,
    );
  }
}
