import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recurring_alarm/core/constant.dart';
import 'package:recurring_alarm/domain/entities/reminder.dart';
import 'package:recurring_alarm/domain/usecases/reminder_usecase.dart';
import 'package:recurring_alarm/presentation/reminder/screens/adding/adding_screen.dart';
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

  String updateText(String text) {
    state = state.copyWith(description: text);
    return state.description;
  }

  void setReminderType(ReminderType type) {
    state = state.copyWith(reminderType: type, lenghtBetweenReminder: 0);
  }

  void setDaysSelected(selectedDays) {
    state = state.copyWith(daysSelected: List<int>.from(selectedDays));
  }

  void setlenghtSelected(int lenghtSelected) {
    state = state.copyWith(lenghtBetweenReminder: lenghtSelected);
  }

  void setWhenMounthSelected(int whenMounthSelected) {
    state = state.copyWith(whenInMonth: whenMounthSelected);
  }

  void setDateSelected(DateTime beginDate) {
    state = state.copyWith(beginDate: beginDate);
  }

  void setTimeSelected(TimeOfDay timeReminder) {
    state = state.copyWith(time: timeReminder);
  }

  void checkIfvalidate(BuildContext context) {
    if (state.description.trim().isEmpty) {
      Fluttertoast.showToast(
        msg: "Vous devez entrer une description pour votre tâche.",
      );

      return;
    } else if (state.daysSelected.length <= 1 &&
        state.reminderType != ReminderType.daily) {
      Fluttertoast.showToast(
        msg: "Vous devez au moins sélectionner un jour.",
      );
      return;
    } else if (state.beginDate == null) {
      Fluttertoast.showToast(
        msg: "Vous devez mettre une date de début à votre tâche",
      );
      return;
    } else if (state.time == null) {
      Fluttertoast.showToast(
        msg: "Vous devez mettre une heure de rappel à votre tâche",
      );
      return;
    }

    addReminder(context);
  }

  void eraseAll() {
    state = state.initial();
  }

  void deleteAll() async {
    state = state.copyWith(loading: true);

    try {
      await _reminderUsecase.deleteAll();

      Fluttertoast.showToast(msg: "reminders supprimé");
    } catch (e) {
      Fluttertoast.showToast(msg: "pas reussi $e");
    }
  }

  void openAddReminder(BuildContext context) {
    eraseAll();
    showReminderBottomSheet(context);
  }

  void fetchAllReminders() async {
    state = state.copyWith(reminders: const AsyncValue.loading());
    try {
      final response = await _reminderUsecase.fetchAllReminders();

      state = state.copyWith(reminders: AsyncValue.data(response));
      Fluttertoast.showToast(
          msg: "reussi nombre de rappels ${response.length}");
    } catch (e) {
      Fluttertoast.showToast(msg: "pas reussi $e");
    }
  }

  void addReminder(BuildContext context) async {
    var currentContext = context;
    state = state.copyWith(loading: true);

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
      fetchAllReminders();
    } catch (e) {
      Fluttertoast.showToast(msg: "pas reussi $e");
    }

    state = state.copyWith(loading: false);
  }

  void closePopup(BuildContext context) {
    Navigator.of(context).pop();
  }
}
