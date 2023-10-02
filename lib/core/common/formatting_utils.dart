import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

String formatTimeToString(TimeOfDay time) {
  return '${time.hour}:${time.minute}';
}

//  parse string DateTime to DateTime

DateTime formatDate(String date) {
  return DateTime.parse(date);
}

String formatDatetoString(DateTime date) {
  return DateFormat.yMMMd().format(date);
}

//  parse a list of DateTime string to DateTime list

List<DateTime> formatMultipleDates(List<String> dates) {
  return dates.map((e) => DateTime.parse(e)).toList();
}

List<String> formatDaysToList(String days) {
  final list = days.split(',');

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
            case SelectedWhenInMonth.begin:
              text = "All the beginnings of the month".hardcoded;
              break;

            case SelectedWhenInMonth.middle:
              text = "Every mid month".hardcoded;
              break;

            case SelectedWhenInMonth.end:
              text = "Every end of the month".hardcoded;
              break;
          }

        case 1:
          switch (reminder.whenInMonth) {
            case SelectedWhenInMonth.begin:
              text = "Beginning of the month, every three months".hardcoded;
              break;

            case SelectedWhenInMonth.middle:
              text = "Middle of the month, every three months".hardcoded;
              break;

            case SelectedWhenInMonth.end:
              text = "End of the month, every three months".hardcoded;
              break;
          }
        case 2:
          switch (reminder.whenInMonth) {
            case SelectedWhenInMonth.begin:
              text = "Beginning of the month, every nine months".hardcoded;
              break;

            case SelectedWhenInMonth.middle:
              text = "Middle of the month, every nine months".hardcoded;
              break;

            case SelectedWhenInMonth.end:
              text = "End of the month, every nine months".hardcoded;
              break;
          }
        case 3:
          switch (reminder.whenInMonth) {
            case SelectedWhenInMonth.begin:
              text = "Beginning of the month, twelve nine months".hardcoded;
              break;

            case SelectedWhenInMonth.middle:
              text = "Middle of the month, every twelve months".hardcoded;
              break;

            case SelectedWhenInMonth.end:
              text = "End of the month, every twelve months".hardcoded;
              break;
          }
      }
  }

  return text;
}
