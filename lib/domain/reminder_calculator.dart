import 'package:intl/intl.dart';
import 'package:recurring_alarm/core/common/formatting_utils.dart';
import 'package:recurring_alarm/core/constant.dart';
import 'package:recurring_alarm/domain/entities/reminder.dart';

Future<List<DateTime>> calculateNextReminder(Reminder reminder) async {
  switch (reminder.reminderType) {
    case ReminderType.daily:
      return calculDailyReminders(reminder);
    case ReminderType.weekly:
      return calculateWeeklyReminders(reminder);
    case ReminderType.monthly:
      return calculMonthReminders(reminder);
  }
}

List<DateTime> calculDailyReminders(Reminder reminder) {
  var currentTime = DateTime.now();
  final reminderDateTime = DateTime(currentTime.year, currentTime.month,
      currentTime.day, reminder.time.hour, reminder.time.minute);

  if (reminderDateTime.isAfter(currentTime)) {
    return [reminderDateTime];
  } else {
    return [
      DateTime(currentTime.year, currentTime.month, (currentTime.day + 1),
          reminder.time.hour, reminder.time.minute)
    ];
  }
}

Future<List<DateTime>> calculateWeeklyReminders(
  Reminder reminder,
) async {
  var days = formatDaysToList(reminder.days.toString());

  var beginDate = reminder.beginDate;

  final currentWeek = <DateTime>[];
  var nextWeekDate = await fetchNextWeek(beginDate);

  for (var day in days) {
    for (var i = 0; i < 7; i++) {
      final reminderDateTime = DateTime(beginDate.year, beginDate.month,
          (beginDate.day + i), reminder.time.hour, reminder.time.minute);

      if (day == DateFormat('EEEE').format(reminderDateTime) &&
          reminderDateTime.isAfter(DateTime.now()) &&
          (reminderDateTime.isBefore(nextWeekDate))) {
        currentWeek.add(reminderDateTime);
      }
    }
  }

  if (currentWeek.isEmpty) {
    return await calculForNextWeeks(reminder, nextWeekDate);

    // fetch date for spacing selected;
  } else {
    return currentWeek;
  }
}

Future<List<DateTime>> calculForNextWeeks(
    Reminder reminder, DateTime beginWeekDate) async {
  var days = formatDaysToList(reminder.days.toString());

  var beginDate = beginWeekDate
      .add(Duration(days: weeklDayCount[reminder.lenghtBetweenReminder]!));
  final currentWeek = <DateTime>[];
  var nextWeekDate = await fetchNextWeek(beginDate);

  // Set to begin Week
  var nextDate =
      DateTime(nextWeekDate.year, nextWeekDate.month, nextWeekDate.day - 7);

  for (var day in days) {
    for (var i = 0; i < 7; i++) {
      final reminderDateTime = DateTime(nextDate.year, nextDate.month,
          (nextDate.day + i), reminder.time.hour, reminder.time.minute);
      if (day == DateFormat('EEEE').format(reminderDateTime) &&
          reminderDateTime.isAfter(DateTime.now()) &&
          (reminderDateTime.isBefore(nextWeekDate))) {
        currentWeek.add(reminderDateTime);
      }
    }
  }

  return currentWeek;
}

Future<List<DateTime>> calculMonthReminders(
  Reminder reminder,
) async {
  var days = formatDaysToList(reminder.days.toString());

  var beginDate = DateTime(reminder.beginDate.year, reminder.beginDate.month,
      whenInMonth[reminder.whenInMonth]!);

  final currentWeek = <DateTime>[];
  var nextWeekDate = await fetchNextWeek(beginDate);

  var nextDate =
      DateTime(nextWeekDate.year, nextWeekDate.month, nextWeekDate.day - 7);
  for (var day in days) {
    for (var i = 0; i < 7; i++) {
      final reminderDateTime = DateTime(nextDate.year, nextDate.month,
          (nextDate.day + i), reminder.time.hour, reminder.time.minute);

      if (day == DateFormat('EEEE').format(reminderDateTime)) {
        if (reminderDateTime.isAfter(DateTime.now()) &&
            (reminderDateTime.isBefore(nextWeekDate))) {
          if (beginDate.month != nextWeekDate.month) {
            // is not the same mounth

            DateTime changeWeek;

            if (beginDate.month < nextWeekDate.month) {
              // Remove one week to stay in the selected month
              // otherwise add one week to go to the selected month
              changeWeek = reminderDateTime.add(const Duration(days: -7));
            } else {
              changeWeek = reminderDateTime.add(const Duration(days: 7));
            }

            currentWeek.add(changeWeek);
          } else {
            // is the same Week
            currentWeek.add(reminderDateTime);
          }
        }
      }
    }
  }

  if (currentWeek.isEmpty) {
    // No date for this month, next month
    return await calculForNextMonth(reminder, nextWeekDate);

    // fetch date for spacing selected;
  } else {
    return currentWeek;
  }
}

Future<List<DateTime>> calculForNextMonth(
    Reminder reminder, DateTime beginWeekDate) async {
  var days = formatDaysToList(reminder.days.toString());

  var beginDate = DateTime(
      beginWeekDate.year,
      beginWeekDate.month + monthDayCount[reminder.lenghtBetweenReminder]!,
      beginWeekDate.day);
  final currentWeek = <DateTime>[];
  var nextWeekDate = await fetchNextWeek(beginDate);

  // Set to begin Week
  var nextDate =
      DateTime(nextWeekDate.year, nextWeekDate.month, nextWeekDate.day - 7);
  for (var day in days) {
    for (var i = 0; i < 7; i++) {
      final reminderDateTime = DateTime(nextDate.year, nextDate.month,
          (nextDate.day + i), reminder.time.hour, reminder.time.minute);

      if (day == DateFormat('EEEE').format(reminderDateTime)) {
        if (reminderDateTime.isAfter(DateTime.now()) &&
            (reminderDateTime.isBefore(nextWeekDate))) {
          if (beginDate.month != nextWeekDate.month) {
            // is not the same mounth

            DateTime changeWeek;

            if (beginDate.month < nextWeekDate.month) {
              // Remove one week to stay in the selected month
              // otherwise add one week to go to the selected month
              changeWeek = reminderDateTime.add(const Duration(days: -7));
            } else {
              changeWeek = reminderDateTime.add(const Duration(days: 7));
            }

            currentWeek.add(changeWeek);
          } else {
            // is the same week
            currentWeek.add(reminderDateTime);
          }
        }
      }
    }
  }

  return currentWeek;
}

Future<DateTime> fetchNextWeek(DateTime beginDate) async {
  DateTime mondayDate = beginDate;

  // looks for the end of the week
  while (DateFormat('EEEE').format(mondayDate) != "Monday") {
    mondayDate = mondayDate.add(const Duration(days: 1));
  }
  return mondayDate;
}
