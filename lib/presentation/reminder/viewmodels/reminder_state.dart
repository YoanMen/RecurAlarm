import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recurring_alarm/core/constant.dart';
import 'package:recurring_alarm/domain/entities/reminder.dart';

@immutable
class ReminderState {
  final String description;
  final ReminderType reminderType;
  final List<int> daysSelected;
  final int lenghtBetweenReminder;
  final int whenInMonth;
  final DateTime? beginDate;
  final List<DateTime>? remindersDate;
  final TimeOfDay? time;
  final AsyncValue<List<Reminder>> reminders;
  final bool loading;
  final bool editingMode;
  final String validatorErrorText;

  const ReminderState({
    this.description = "",
    this.reminderType = ReminderType.daily,
    required this.daysSelected,
    this.lenghtBetweenReminder = 0,
    this.whenInMonth = 0,
    this.beginDate,
    this.remindersDate,
    this.time,
    this.editingMode = false,
    required this.reminders,
    this.loading = false,
    this.validatorErrorText = "",
  });

  ReminderState copyWith({
    String? description,
    ReminderType? reminderType,
    List<int>? daysSelected,
    int? lenghtBetweenReminder,
    int? whenInMonth,
    DateTime? beginDate,
    List<DateTime>? remindersDate,
    TimeOfDay? time,
    List<Reminder>? passedReminder,
    List<Reminder>? todayReminder,
    List<Reminder>? weekReminder,
    List<Reminder>? laterReminder,
    AsyncValue<List<Reminder>>? reminders,
    bool? loading,
    bool? editingMode,
    String? validatorErrorText,
  }) {
    return ReminderState(
        description: description ?? this.description,
        reminderType: reminderType ?? this.reminderType,
        whenInMonth: whenInMonth ?? this.whenInMonth,
        daysSelected: daysSelected ?? this.daysSelected,
        lenghtBetweenReminder:
            lenghtBetweenReminder ?? this.lenghtBetweenReminder,
        beginDate: beginDate ?? this.beginDate,
        remindersDate: remindersDate ?? this.remindersDate,
        time: time ?? this.time,
        reminders: reminders ?? this.reminders,
        loading: loading ?? this.loading,
        editingMode: editingMode ?? this.editingMode,
        validatorErrorText: validatorErrorText ?? this.validatorErrorText);
  }

  ReminderState initial({
    AsyncValue<List<Reminder>>? reminders,
    bool? loading,
  }) {
    return ReminderState(
        description: "",
        reminderType: ReminderType.daily,
        whenInMonth: 0,
        daysSelected: const [0],
        lenghtBetweenReminder: 0,
        beginDate: null,
        time: null,
        remindersDate: null,
        reminders: reminders ?? this.reminders,
        loading: loading ?? this.loading,
        validatorErrorText: '');
  }

  @override
  bool operator ==(covariant ReminderState other) {
    if (identical(this, other)) return true;

    return other.description == description &&
        other.reminderType == reminderType &&
        other.daysSelected == daysSelected &&
        other.lenghtBetweenReminder == lenghtBetweenReminder &&
        other.whenInMonth == whenInMonth &&
        other.beginDate == beginDate &&
        other.remindersDate == remindersDate &&
        other.time == time &&
        other.reminders == reminders &&
        other.loading == loading &&
        other.editingMode == editingMode &&
        other.validatorErrorText == validatorErrorText;
  }

  @override
  int get hashCode {
    return description.hashCode ^
        reminderType.hashCode ^
        daysSelected.hashCode ^
        lenghtBetweenReminder.hashCode ^
        whenInMonth.hashCode ^
        beginDate.hashCode ^
        remindersDate.hashCode ^
        time.hashCode ^
        reminders.hashCode ^
        loading.hashCode ^
        editingMode.hashCode ^
        validatorErrorText.hashCode;
  }

  @override
  String toString() {
    return 'ReminderFlowState(description: $description, reminderType: $reminderType, daysSelected: $daysSelected, lenghtBetweenReminder: $lenghtBetweenReminder, whenInMonth: $whenInMonth, beginDate: $beginDate, remindersDate: $remindersDate, timeReminder: $time, reminders: $reminders, loading: $loading, editingMode: $editingMode, validatorErrorText: $validatorErrorText)';
  }
}
