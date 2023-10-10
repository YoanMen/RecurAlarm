import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recurring_alarm/core/constant.dart';
import 'package:recurring_alarm/domain/entities/reminder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// format a string type '08:30' to a TimeOfDay

TimeOfDay formatTime(String time) {
  // Divisez la chaîne en heures et minutes
  List<String> timeParts = time.split(":");
  int hours = int.parse(timeParts[0]);
  int minutes = int.parse(timeParts[1]);

  return TimeOfDay(hour: hours, minute: minutes);
}

DateTime formatDate(String date) {
  return DateTime.parse(date);
}

String formatDatetoString(DateTime date, BuildContext context) {
  return DateFormat.yMMMd(AppLocalizations.of(context)!.localeName)
      .format(date);
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

String lenghtBettewenReminding(Reminder reminder, BuildContext context) {
  String text = "";
  switch (reminder.reminderType) {
    case ReminderType.daily:
      text = AppLocalizations.of(context)!.everyDays;
      break;
    case ReminderType.weekly:
      switch (reminder.lenghtBetweenReminder) {
        case 0:
          text = AppLocalizations.of(context)!.everyWeek;
          break;
        case 1:
          text = AppLocalizations.of(context)!.everyTwoWeeks;
          break;

        case 2:
          text = AppLocalizations.of(context)!.everyThreeWeeks;
          break;
      }
    case ReminderType.monthly:
      switch (reminder.lenghtBetweenReminder) {
        case 0:
          switch (reminder.whenInMonth) {
            case SelectedWhenInMonth.begin:
              text = AppLocalizations.of(context)!.allBeginMonth;
              break;

            case SelectedWhenInMonth.middle:
              text = AppLocalizations.of(context)!.everyMidMonth;
              break;

            case SelectedWhenInMonth.end:
              text = AppLocalizations.of(context)!.everyEndMonth;
              break;
          }

        case 1:
          switch (reminder.whenInMonth) {
            case SelectedWhenInMonth.begin:
              text = AppLocalizations.of(context)!.beginThreeMonth;
              break;

            case SelectedWhenInMonth.middle:
              text = AppLocalizations.of(context)!.midThreeMonth;
              break;

            case SelectedWhenInMonth.end:
              text = AppLocalizations.of(context)!.endThreeMonth;
              break;
          }
        case 2:
          switch (reminder.whenInMonth) {
            case SelectedWhenInMonth.begin:
              text = AppLocalizations.of(context)!.beginNineMonth;
              break;

            case SelectedWhenInMonth.middle:
              text = AppLocalizations.of(context)!.midNineMonth;
              break;

            case SelectedWhenInMonth.end:
              text = AppLocalizations.of(context)!.endNineMonth;
              break;
          }
        case 3:
          switch (reminder.whenInMonth) {
            case SelectedWhenInMonth.begin:
              text = AppLocalizations.of(context)!.beginTwelveMonth;
              break;

            case SelectedWhenInMonth.middle:
              text = AppLocalizations.of(context)!.midTwelveMonth;
              break;

            case SelectedWhenInMonth.end:
              text = AppLocalizations.of(context)!.endTwelveMonth;
              break;
          }
      }
  }

  return text;
}
