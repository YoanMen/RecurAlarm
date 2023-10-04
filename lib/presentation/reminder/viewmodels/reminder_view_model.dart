import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recurring_alarm/core/constant.dart';
import 'package:recurring_alarm/domain/entities/reminder.dart';
import 'package:recurring_alarm/domain/notification_manager.dart';
import 'package:recurring_alarm/domain/usecases/reminder_usecase.dart';
import 'package:recurring_alarm/presentation/reminder/screens/adding/adding_screen.dart';
import 'package:recurring_alarm/presentation/reminder/screens/editing/editing_screen.dart';
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
    //deleteAll();
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
      state = state.copyWith(
          validatorErrorText:
              "Vous devez entrer une description pour votre tâche.");

      return;
    } else if (state.daysSelected.length <= 1 &&
        state.reminderType != ReminderType.daily) {
      state = state.copyWith(
        validatorErrorText: "Vous devez au moins sélectionner un jour.",
      );
      return;
    } else if (state.beginDate == null) {
      state = state.copyWith(
        validatorErrorText: "Vous devez mettre une date de début à votre tâche",
      );
      return;
    } else if (state.time == null) {
      state = state.copyWith(
        validatorErrorText:
            "Vous devez mettre une heure de rappel à votre tâche",
      );
      return;
    }

    state.editingMode ? updateReminder(context) : addReminder(context);
  }

  void eraseAllReminderSetting() {
    state = state.initial();
  }

  void setEditReminderSetting(Reminder reminder) {
    state = state.copyWith(
        validatorErrorText: "",
        editingMode: true,
        reminderOnEdit: reminder,
        beginDate: reminder.beginDate,
        daysSelected: reminder.days,
        description: reminder.description,
        lenghtBetweenReminder: reminder.lenghtBetweenReminder,
        reminderType: reminder.reminderType,
        remindersDate: reminder.remindersDate,
        time: reminder.time,
        whenInMonth: reminder.whenInMonth.index);
  }

  void removeReminder(Reminder reminder) async {
    try {
      await _reminderUsecase.removeReminder(reminder);
      Fluttertoast.showToast(msg: "reminder delete");
      fetchAllReminders();
    } catch (e) {
      Fluttertoast.showToast(msg: "error: $e");
      state = state.copyWith(loading: false);
    }
  }

  void toggleSelected(Reminder reminder) async {
    state = state.copyWith(
      reminders: AsyncValue.data([
        for (final oldReminder in state.reminders.asData!.value)
          if (oldReminder == reminder)
            reminder.toggleSelected()
          else
            oldReminder
      ]),
    );
    // get all option setting by user
    final newReminder = Reminder(
        description: reminder.description,
        beginDate: reminder.beginDate,
        createAt: reminder.createAt,
        days: reminder.days,
        lenghtBetweenReminder: reminder.lenghtBetweenReminder,
        reminderEnable: !reminder.reminderEnable,
        reminderType: reminder.reminderType,
        time: reminder.time,
        uuid: reminder.uuid,
        remindersDate: reminder.remindersDate,
        whenInMonth: reminder.whenInMonth);

    await _reminderUsecase.updateToggleReminder(newReminder);
  }

  void deleteAll() async {
    // state = state.copyWith(loading: true);

    // try {
    //   await _reminderUsecase.deleteAll();

    //   Fluttertoast.showToast(msg: "reminders supprimé");
    // } catch (e) {
    //   Fluttertoast.showToast(msg: "pas reussi $e");
    // }

    // fetchAllReminders();
    // await Future.delayed(const Duration(milliseconds: 600));

    // state = state.copyWith(loading: false);
  }

  void openAddReminder(BuildContext context) {
    eraseAllReminderSetting();
    addReminderBottomSheet(context);
  }

  void openEditReminder(
      {required BuildContext context, required Reminder reminder}) {
    setEditReminderSetting(reminder);
    editReminderBottomSheet(context);
  }

  void fetchAllReminders() async {
    state = state.copyWith(loading: true);
    try {
      final response = await _reminderUsecase.fetchAllReminders();

      state = state.copyWith(reminders: AsyncValue.data(response));
    } catch (e) {
      Fluttertoast.showToast(msg: "pas reussi $e");
    }
    await Future.delayed(const Duration(milliseconds: 600));
    state = state.copyWith(loading: false);
  }

  void addReminder(BuildContext context) async {
    final navigator = Navigator.of(context);

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
      navigator.pop();
      fetchAllReminders();
    } catch (e) {
      Fluttertoast.showToast(msg: "erreur : $e");
    }
  }

  void updateReminder(BuildContext context) async {
    final navigator = Navigator.of(context);
    // get all option setting by user
    final newReminder = Reminder(
        description: state.description,
        beginDate: state.beginDate!,
        createAt: state.reminderOnEdit!.createAt,
        days: state.daysSelected,
        lenghtBetweenReminder: state.lenghtBetweenReminder,
        reminderEnable: state.reminderOnEdit!.reminderEnable,
        reminderType: state.reminderType,
        time: state.time!,
        uuid: state.reminderOnEdit!.uuid,
        whenInMonth: SelectedWhenInMonth.values[state.whenInMonth]);

    try {
      await _reminderUsecase.updateReminder(newReminder);
      Fluttertoast.showToast(msg: "Rappel modifié");
      navigator.pop();
      fetchAllReminders();
    } catch (e) {
      Fluttertoast.showToast(msg: "erreur : $e");
    }
  }

  void closePopup(BuildContext context) {
    Navigator.of(context).pop();
  }
}
