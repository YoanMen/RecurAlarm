import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recurring_alarm/core/constant.dart';
import 'package:recurring_alarm/domain/entities/reminder.dart';
import 'package:recurring_alarm/domain/reminder_calculator.dart';

void main() {
  group("Calculate reminder dates ", () {
    test("Caluculate the next reminder date day whith custom begin Date",
        () async {
      Reminder reminderMock = Reminder(
          description: "mock desciption",
          beginDate: DateTime.now(),
          reminderType: ReminderType.daily,
          lenghtBetweenReminder: 0,
          days: const [1, 7],
          whenInMonth: SelectedWhenInMonth.values[0],
          time: const TimeOfDay(hour: 8, minute: 0),
          uuid: 1151511,
          createAt: DateTime.now(),
          reminderEnable: true);

      var result = await calculateNextReminder(reminderMock);
      expect(true, result[0].isAfter(DateTime.now()));
    });
  });

  test("calcul date for end month with custom date", () async {
    Reminder reminderMock = Reminder(
        description: "mock desciption",
        beginDate: DateTime(2023, 3, 2),
        reminderType: ReminderType.monthly,
        lenghtBetweenReminder: 0,
        days: const [1],
        whenInMonth: SelectedWhenInMonth.values[2],
        time: const TimeOfDay(hour: 16, minute: 30),
        uuid: 5151,
        createAt: DateTime.now(),
        reminderEnable: true);

    var result = await calculateNextReminder(reminderMock);

    expect(true, result[0].isAfter(DateTime.now()));
  });

  test("calcul date for begin month with custom date", () async {
    Reminder reminderMock = Reminder(
        description: "mock description",
        beginDate: DateTime(2024, 1, 20),
        reminderType: ReminderType.monthly,
        lenghtBetweenReminder: 0,
        days: const [0, 1],
        whenInMonth: SelectedWhenInMonth.values[0],
        time: const TimeOfDay(hour: 16, minute: 30),
        uuid: 51515,
        createAt: DateTime.now(),
        reminderEnable: true);
    var result = await calculateNextReminder(reminderMock);

    expect(true, result[0].isAfter(DateTime.now()));
  });

  test("calcul date weekly with custom date", () async {
    Reminder reminderMock = Reminder(
        description: "mock description",
        beginDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        reminderType: ReminderType.weekly,
        lenghtBetweenReminder: 0,
        days: const [
          0,
          1,
        ],
        whenInMonth: SelectedWhenInMonth.values[0],
        time: const TimeOfDay(hour: 8, minute: 30),
        uuid: 51511,
        createAt: DateTime.now(),
        reminderEnable: true);
    var result = await calculateNextReminder(reminderMock);

    expect(true, result[0].isAfter(DateTime.now()));
  });
}
