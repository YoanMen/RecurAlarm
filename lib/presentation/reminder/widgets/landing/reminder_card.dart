import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recurring_alarm/core/common/formatting_utils.dart';
import 'package:recurring_alarm/domain/entities/reminder.dart';
import 'package:recurring_alarm/domain/reminder_calculator.dart';
import 'package:recurring_alarm/presentation/reminder/viewmodels/reminder_view_model.dart';

class ReminderCard extends ConsumerWidget {
  const ReminderCard({Key? key, required this.reminder}) : super(key: key);

  final Reminder reminder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "${reminder.time.hour}:${reminder.time.minute}",
                    style: const TextStyle(
                        fontSize: 36, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit,
                      size: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                reminder.description,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date next Reminder",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.40),
                              fontSize: 14)),
                      Text(
                        _shortDayString(reminder.days.toString()),
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.40),
                            fontSize: 14),
                      ),
                      Text(lenghtBettewenReminding(reminder),
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.40),
                              fontSize: 14)),
                    ],
                  ),
                  const Spacer(),
                  Switch.adaptive(
                    value: reminder.reminderEnable,
                    onChanged: (value) {}, // toogle activate
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _dayToIndex(String day) {
    switch (day) {
      case 'mon':
        return 0;
      case 'tue':
        return 1;
      case 'wed':
        return 2;
      case 'thu':
        return 3;
      case 'fri':
        return 4;
      case 'sat':
        return 5;
      case 'sun':
        return 6;
      default:
        return -1; // Jour inconnu
    }
  }

  String _shortDayString(String daysSelected) {
    var days = daysSelected
        .split(",")
        .map((e) => e.replaceAll("SelectedDay.", ""))
        .toList();

    if (days.length == 1) {
      return days[0];
    } else {
      List<String> shortedDays =
          days.map((day) => day.substring(0, 3)).toList();
      shortedDays.sort((a, b) => _dayToIndex(a).compareTo(_dayToIndex(b)));

      return shortedDays.join("., ");
    }
  }
}
