// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  @override
  String toString() =>
      'Settings(notifiedTomorrow: $notifiedTomorrow, darkMode: $darkMode, alarmMode: $alarmMode)';

  @override
  bool operator ==(covariant Settings other) {
    if (identical(this, other)) return true;

    return other.notifiedTomorrow == notifiedTomorrow &&
        other.darkMode == darkMode &&
        other.alarmMode == alarmMode;
  }

  @override
  int get hashCode =>
      notifiedTomorrow.hashCode ^ darkMode.hashCode ^ alarmMode.hashCode;
}
