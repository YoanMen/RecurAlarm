import 'package:flutter/material.dart';
import 'package:recurring_alarm/core/constant.dart';
import 'package:recurring_alarm/domain/entities/reminder.dart';

Future<List<DateTime>> calculateNextReminder(Reminder reminder) async {
  switch (reminder.reminderType) {
    case ReminderType.daily:
      return calculateDailyReminders(reminder);
    case ReminderType.weekly:
      return calculateWeeklyReminders(reminder);
    case ReminderType.monthly:
      return calculateMonthlyReminders(reminder);
  }
}

List<DateTime> calculateDailyReminders(Reminder reminder) {
  var reminderDateTime = DateTime(
    reminder.beginDate.year,
    reminder.beginDate.month,
    reminder.beginDate.day,
    reminder.time.hour,
    reminder.time.minute,
  );

  while (reminderDateTime.isBefore(DateTime.now())) {
    reminderDateTime = reminderDateTime.add(const Duration(days: 1));
  }

  return (reminderDateTime.isAfter(DateTime.now()))
      ? [reminderDateTime]
      : [
          DateTime(
            reminder.beginDate.year,
            reminder.beginDate.month,
            reminder.beginDate.day + 1,
            reminder.time.hour,
            reminder.time.minute,
          ),
        ];
}

Future<List<DateTime>> calculateWeeklyReminders(Reminder reminder) async {
  List<DateTime> dates = [];

  DateTime dateToStartSearch = DateTime(
    reminder.beginDate.year,
    reminder.beginDate.month,
    reminder.beginDate.day,
    reminder.time.hour,
    reminder.time.minute,
  );

  // search in current week

  DateTime endOfWeekDate = await fetchNextWeek(dateToStartSearch);

  DateTime searchDate = endOfWeekDate.add(const Duration(days: -7));

  dates = searchValidDates(searchDate, reminder);

  if (dates.isEmpty) {
    if (dateToStartSearch.isAfter(DateTime.now())) {
      DateTime endOfWeekDate = await fetchNextWeek(dateToStartSearch);

      DateTime searchDate = endOfWeekDate.add(const Duration(days: -7));

      dates = searchValidDates(searchDate, reminder);
    } else {
      DateTime currentDate = DateTime(
        reminder.beginDate.year,
        reminder.beginDate.month,
        reminder.beginDate.day,
      );
      while (currentDate.isBefore(DateTime.now())) {
        currentDate = DateUtils.addDaysToDate(
            currentDate, weeklDayCount[reminder.lenghtBetweenReminder]!);
      }

      DateTime endOfWeekDate = await fetchNextWeek(currentDate);

      DateTime searchDate = endOfWeekDate.add(const Duration(days: -7));

      dates = searchValidDates(searchDate, reminder);
    }
  }
  dates.sort();
  return dates;
}

Future<List<DateTime>> calculateMonthlyReminders(Reminder reminder) async {
  List<DateTime> dates = [];

  DateTime dateToStartSearch = DateTime(
    reminder.beginDate.year,
    reminder.beginDate.month,
    whenInMonth[reminder.whenInMonth.name]!,
    reminder.time.hour,
    reminder.time.minute,
  );

  DateTime endOfWeekDate = await fetchNextWeek(dateToStartSearch);

  dates = searchValidDates(endOfWeekDate, reminder);

  if (dates.isEmpty) {
    if (dateToStartSearch.isAfter(DateTime.now())) {
      DateTime endOfWeekDate = await fetchNextWeek(dateToStartSearch);

      dates = searchValidDates(endOfWeekDate, reminder);
    } else {
      DateTime currentDate = DateTime(reminder.beginDate.year,
          reminder.beginDate.month, whenInMonth[reminder.whenInMonth.name]!);

      while (currentDate.isBefore(DateTime.now())) {
        currentDate = DateUtils.addMonthsToMonthDate(
            currentDate, monthCount[reminder.lenghtBetweenReminder]!);

        currentDate = DateTime(currentDate.year, currentDate.month,
            whenInMonth[reminder.whenInMonth.name]!);
      }
      DateTime searchDate = await fetchNextWeek(currentDate);

      dates = searchValidDates(searchDate, reminder);
    }
  }
  dates.sort();
  return dates;
}

Future<DateTime> fetchNextWeek(DateTime beginDate) async {
  DateTime endWeekDate = beginDate;

  while (endWeekDate.weekday != 7) {
    endWeekDate = endWeekDate.add(const Duration(days: 1));
  }

  return endWeekDate;
}

List<DateTime> searchValidDates(DateTime searchDate, Reminder reminder) {
  List<DateTime> dates = [];

  for (var day in reminder.days) {
    for (var i = 1; i <= 7; i++) {
      final reminderDateTime = DateTime(
        searchDate.year,
        searchDate.month,
        searchDate.day + i,
        reminder.time.hour,
        reminder.time.minute,
      );

      if (day == i && reminderDateTime.isAfter(DateTime.now())) {
        dates.add(reminderDateTime);
      }
    }
  }

  return dates;
}
