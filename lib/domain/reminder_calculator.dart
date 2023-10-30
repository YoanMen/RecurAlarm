import 'package:flutter/material.dart';
import 'package:recurring_alarm/core/constant.dart';
import 'package:recurring_alarm/domain/entities/reminder.dart';

Future<List<DateTime>> calculateNextReminder(Reminder reminder) async {
  switch (reminder.reminderType) {
    case ReminderType.daily:
      return await calculateDailyReminders(reminder);
    case ReminderType.weekly:
      return await calculateWeeklyReminders(reminder);
    case ReminderType.monthly:
      return await calculateMonthlyReminders(reminder);
  }
}

//* Daily Calculate
Future<List<DateTime>> calculateDailyReminders(Reminder reminder) async {
  var reminderDateTime = DateTime(
    reminder.beginDate.year,
    reminder.beginDate.month,
    reminder.beginDate.day,
    reminder.time.hour,
    reminder.time.minute,
  );

  while (reminderDateTime.isBefore(DateTime.now())) {
    DateTime newDateTime = reminderDateTime.add(const Duration(days: 1));

    reminderDateTime = DateTime(newDateTime.year, newDateTime.month,
        newDateTime.month, reminder.time.hour, reminder.time.minute);
  }

  return [reminderDateTime];
}

//* Weekly Calculate
Future<List<DateTime>> calculateWeeklyReminders(Reminder reminder) async {
  List<DateTime> dates = [];

  DateTime dateToStartSearch = DateTime(
    reminder.beginDate.year,
    reminder.beginDate.month,
    reminder.beginDate.day,
    reminder.time.hour,
    reminder.time.minute,
  );

  // search a valid date in a week
  DateTime endOfWeekDate = await fetchNextWeek(dateToStartSearch);

  // use - 7 days for searching in begin of week.
  dates =
      searchValidDates(endOfWeekDate.add(const Duration(days: -7)), reminder);

  if (dates.isEmpty) {
    // if no dates founded in week date of begin search
    // add week and search valid dates

    DateTime currentDate = DateTime(reminder.beginDate.year,
            reminder.beginDate.month, reminder.beginDate.day)
        .add(Duration(days: weeklDayCount[reminder.lenghtBetweenReminder]!));

    while (currentDate.isBefore(reminder.beginDate)) {
      currentDate = DateUtils.addDaysToDate(
          currentDate, weeklDayCount[reminder.lenghtBetweenReminder]!);
    }

    DateTime searchDate = await fetchNextWeek(currentDate);

    dates =
        searchValidDates(searchDate.add(const Duration(days: -7)), reminder);
  }

  dates.sort();
  return dates;
}

//* Monthly Calculate
Future<List<DateTime>> calculateMonthlyReminders(Reminder reminder) async {
  List<DateTime> dates = [];

  DateTime dateToStartSearch = DateTime(
    reminder.beginDate.year,
    reminder.beginDate.month,
    whenInMonth[reminder.whenInMonth.name]!,
    reminder.time.hour,
    reminder.time.minute,
  );
  if (dateToStartSearch.isAfter(reminder.beginDate)) {
    DateTime endOfWeekDate = await fetchNextWeek(dateToStartSearch);

    dates = searchValidDates(endOfWeekDate, reminder);
  }
  if (dates.isEmpty) {
    DateTime currentDate = DateTime(reminder.beginDate.year,
        reminder.beginDate.month, whenInMonth[reminder.whenInMonth.name]!);

    while (currentDate.isBefore(reminder.beginDate)) {
      currentDate = DateUtils.addMonthsToMonthDate(
          currentDate, monthCount[reminder.lenghtBetweenReminder]!);
      currentDate = DateTime(currentDate.year, currentDate.month,
          whenInMonth[reminder.whenInMonth.name]!);
    }

    DateTime searchDate = await fetchNextWeek(currentDate);

    dates = searchValidDates(searchDate, reminder);
  }

  dates.sort();
  return dates;
}

//* Search next week of begin date
Future<DateTime> fetchNextWeek(DateTime beginDate) async {
  DateTime endWeekDate = beginDate;

  while (endWeekDate.weekday != 7) {
    endWeekDate = endWeekDate.add(const Duration(days: 1));
  }

  return endWeekDate;
}

//* Search date = day selected.
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
