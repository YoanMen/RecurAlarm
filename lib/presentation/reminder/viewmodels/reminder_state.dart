import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recurring_alarm/core/constant.dart';
import 'package:recurring_alarm/domain/entities/reminder.dart';

@immutable
class ReminderState {
  // UI State
  final bool loading;
  final bool editingMode;
  final String validatorErrorText;
  final AsyncValue<List<Reminder>> reminders;
  // Reminder state
  final String description;
  final DateTime? beginDate;
  final TimeOfDay? time;
  final List<int> daysSelected;
  final ReminderType reminderType;
  final List<DateTime>? remindersDate;
  final int lenghtBetweenReminder;
  final int whenInMonth;
  final Reminder? reminderOnEdit;

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
    this.reminderOnEdit,
    required this.reminders,
    this.loading = true,
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
    AsyncValue<List<Reminder>>? reminders,
    bool? loading,
    bool? editingMode,
    String? validatorErrorText,
    Reminder? reminderOnEdit,
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
        validatorErrorText: validatorErrorText ?? this.validatorErrorText,
        reminderOnEdit: reminderOnEdit ?? this.reminderOnEdit);
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
        reminderOnEdit: null,
        editingMode: false,
        reminders: reminders ?? this.reminders,
        loading: false,
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
        other.validatorErrorText == validatorErrorText &&
        other.reminderOnEdit == reminderOnEdit;
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
        validatorErrorText.hashCode ^
        reminderOnEdit.hashCode;
  }

  @override
  String toString() {
    return 'ReminderFlowState(description: $description, reminderType: $reminderType, daysSelected: $daysSelected, lenghtBetweenReminder: $lenghtBetweenReminder, whenInMonth: $whenInMonth, beginDate: $beginDate, remindersDate: $remindersDate, timeReminder: $time, reminders: $reminders, loading: $loading, editingMode: $editingMode, validatorErrorText: $validatorErrorText, reminderOnEdit: $reminderOnEdit)';
  }
}
