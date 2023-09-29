import 'package:flutter/material.dart';
import 'package:recurring_alarm/core/constant.dart';
import 'package:recurring_alarm/domain/entities/reminder.dart';
import 'package:recurring_alarm/localization/string_hardcoded.dart';

// format a string type '08:30' to a TimeOfDay

TimeOfDay formatTime(String time) {
  // Divisez la chaîne en heures et minutes
  List<String> timeParts = time.split(":");
  int hours = int.parse(timeParts[0]);
  int minutes = int.parse(timeParts[1]);

  return TimeOfDay(hour: hours, minute: minutes);
}

//  parse string DateTime to DateTime

DateTime formatDate(String date) {
  return DateTime.parse(date);
}

//  parse a list of DateTime string to DateTime list

List<DateTime> formatMultipleDates(List<String> dates) {
  return dates.map((e) => DateTime.parse(e)).toList();
}

// Converts a string of days ("monday, friday")
// to the Set<SelectedDay> corresponding to its day.

Set<SelectedDay> formatDaysToSelectedDays(String days) {
  List<String> selectedDaysList = days.split(',');

  Set<SelectedDay> selectedDays = selectedDaysList.map((day) {
    return SelectedDay.values.firstWhere((e) {
      return e.toString() == day;
    });
  }).toSet();

  return selectedDays;
}

List<String> formatDaysToList(String days) {
  final list = days
      .replaceAll('}', "")
      .replaceAll("SelectedDay.", "")
      .trim()
      .split(', ');

  list.removeAt(0); // remove nothing days

  // add maj for first letter
  final capitalizedDays = list.map((day) {
    if (day.isNotEmpty) {
      return day[0].toUpperCase() + day.substring(1);
    } else {
      return day;
    }
  }).toList();
  return capitalizedDays;
}

String lenghtBettewenReminding(Reminder reminder) {
  String text = "";
  switch (reminder.reminderType) {
    case ReminderType.daily:
      text = "Every days".hardcoded;
      break;
    case ReminderType.weekly:
      switch (reminder.lenghtBetweenReminder) {
        case 0:
          text = "Every week".hardcoded;
          break;
        case 1:
          text = "Every two weeks".hardcoded;
          break;

        case 2:
          text = "Every three weeks".hardcoded;
          break;
      }
    case ReminderType.monthly:
      switch (reminder.lenghtBetweenReminder) {
        case 0:
          switch (reminder.whenInMonth) {
            case 0:
              text = "All the beginnings of the month".hardcoded;
              break;

            case 1:
              text = "Every mid month".hardcoded;
              break;

            case 2:
              text = "Every end of the month".hardcoded;
              break;
          }

        case 1:
          switch (reminder.whenInMonth) {
            case 0:
              text = "Beginning of the month, every three months".hardcoded;
              break;

            case 1:
              text = "Middle of the month, every three months".hardcoded;
              break;

            case 2:
              text = "End of the month, every three months".hardcoded;
              break;
          }
        case 2:
          switch (reminder.whenInMonth) {
            case 0:
              text = "Beginning of the month, every nine months".hardcoded;
              break;

            case 1:
              text = "Middle of the month, every nine months".hardcoded;
              break;

            case 2:
              text = "End of the month, every nine months".hardcoded;
              break;
          }
        case 3:
          switch (reminder.whenInMonth) {
            case 0:
              text = "Beginning of the month, twelve nine months".hardcoded;
              break;

            case 1:
              text = "Middle of the month, every twelve months".hardcoded;
              break;

            case 2:
              text = "End of the month, every twelve months".hardcoded;
              break;
          }
      }
  }

  return text;
}
