import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recurring_alarm/core/constant.dart';
import 'package:recurring_alarm/domain/entities/reminder.dart';

@immutable
class ReminderState {
  final String description;
  final ReminderType reminderType;
  final Set<SelectedDay> daysSelected;
  final int lenghtBetweenReminder;
  final int whenInMonth;
  final DateTime? beginDate;
  final List<DateTime>? remindersDate;
  final TimeOfDay? time;
  final AsyncValue<List<Reminder>> reminders;
  final bool loading;
  final bool editingMode;

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
  });

  ReminderState copyWith({
    String? description,
    ReminderType? reminderType,
    Set<SelectedDay>? daysSelected,
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
        editingMode: editingMode ?? this.editingMode);
  }

  ReminderState initial({
    AsyncValue<List<Reminder>>? reminders,
    bool? loading,
  }) {
    return ReminderState(
        description: "",
        reminderType: ReminderType.daily,
        whenInMonth: 0,
        daysSelected: const <SelectedDay>{SelectedDay.nothing},
        lenghtBetweenReminder: 0,
        beginDate: null,
        time: null,
        remindersDate: null,
        reminders: reminders ?? this.reminders,
        loading: loading ?? this.loading);
  }

  @override
  bool operator ==(covariant ReminderState other) {
    if (identical(this, other)) return true;

    return other.description == description &&
        other.reminderType == reminderType &&
        setEquals(other.daysSelected, daysSelected) &&
        other.lenghtBetweenReminder == lenghtBetweenReminder &&
        other.whenInMonth == whenInMonth &&
        other.beginDate == beginDate &&
        other.remindersDate == remindersDate &&
        other.time == time &&
        other.reminders == reminders &&
        other.loading == loading &&
        other.editingMode == editingMode;
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
        editingMode.hashCode;
  }

  @override
  String toString() {
    return 'ReminderFlowState(description: $description, reminderType: $reminderType, daysSelected: $daysSelected, lenghtBetweenReminder: $lenghtBetweenReminder, whenInMonth: $whenInMonth, beginDate: $beginDate, remindersDate: $remindersDate, timeReminder: $time, reminders: $reminders, loading: $loading, editingMode: $editingMode)';
  }
}
