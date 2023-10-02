import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:recurring_alarm/core/constant.dart';
import 'package:recurring_alarm/domain/entities/reminder.dart';
import 'package:recurring_alarm/domain/usecases/reminder_usecase.dart';
import 'package:recurring_alarm/presentation/reminder/viewmodels/reminder_state.dart';
import 'package:uuid/uuid.dart';

final reminderViewModel =
    StateNotifierProvider<ReminderViewModel, ReminderState>((ref) {
  return ReminderViewModel(
      const ReminderState(daysSelected: [0], reminders: AsyncValue.data([])),
      ref.read(reminderUsecaseProvider));
});

class ReminderViewModel extends StateNotifier<ReminderState> {
  ReminderViewModel(ReminderState state, this._reminderUsecase)
      : super(
          state,
        ) {
    fetchAllReminders();
  }

  final ReminderUsecase _reminderUsecase;

  void deleteAll() async {
    state = state.copyWith(loading: true);

    try {
      final response = await _reminderUsecase.deleteAll();

      Fluttertoast.showToast(msg: "reminders supprimé");
    } catch (e) {
      Fluttertoast.showToast(msg: "pas reussi $e");
    }
  }

  void fetchAllReminders() async {
    state = state.copyWith(loading: true);

    try {
      final response = await _reminderUsecase.fetchAllReminders();

      state = state.copyWith(reminders: AsyncValue.data(response));
      Fluttertoast.showToast(
          msg: "reussi nombre de rappels ${response.length}");
    } catch (e) {
      Fluttertoast.showToast(msg: "pas reussi $e");
    }

    state = state.copyWith(loading: false);
  }

  void addReminder() async {
    // get all option setting by user

    final newReminder = Reminder(
        description: state.description,
        beginDate: state.beginDate!,
        createAt: DateTime.now(),
        days: state.daysSelected,
        lenghtBetweenReminder: state.lenghtBetweenReminder,
        reminderEnable: true,
        reminderType: state.reminderType,
        time: state.time!,
        uuid: const Uuid().v1(),
        whenInMonth: SelectedWhenInMonth.values[state.whenInMonth]);

    try {
      await _reminderUsecase.addReminder(newReminder);

      Fluttertoast.showToast(msg: "Rappel ajouté");
    } catch (e) {
      Fluttertoast.showToast(msg: "pas reussi $e");
    }
  }
}
