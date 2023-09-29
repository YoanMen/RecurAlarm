import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recurring_alarm/core/constant.dart';

TimeOfDay formatTime(String time) {
  DateTime dateTime = DateFormat("HH:mm").parse(time);
  return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
}

DateTime formatDate(String date) {
  return DateTime.now();
}

List<DateTime> formatMultipleDates(List<String> dates) {
  return [];
}

Set<SelectedDay> formatDaysToSelectedDays(String days) {
  // Retirer les accolades
  var selectedDaysString = days.replaceAll('{', '').replaceAll('}', '');

  // Diviser la chaîne en une liste de jours
  List<String> selectedDaysList = selectedDaysString.split(', ');

  // Convertir la liste de chaînes en un ensemble Set<SelectedDay>
  Set<SelectedDay> selectedDays = selectedDaysList.map((day) {
    return SelectedDay.values.firstWhere((e) => e.toString() == day);
  }).toSet();

  return selectedDays;
}
