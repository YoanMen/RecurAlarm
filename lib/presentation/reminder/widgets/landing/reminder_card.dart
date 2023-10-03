import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:recurring_alarm/core/common/formatting_utils.dart';
import 'package:recurring_alarm/domain/entities/reminder.dart';
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
                    reminder.time.format(context),
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
                      Text(
                          DateFormat.MMMEd().format(reminder.remindersDate![0]),
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.40),
                              fontSize: 14)),
                      Text(
                        _shortDayString(reminder.days),
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

  String _dayToString(int day) {
    switch (day) {
      case 0:
        return "";
      case 1:
        return "monday";
      case 2:
        return "tuesday";
      case 3:
        return "wedesday";
      case 4:
        return "thuesday";
      case 5:
        return "friday";
      case 6:
        return "saturday";
      case 7:
        return "sunday";
      default:
        return ""; // Jour inconnu
    }
  }

  String _shortDayString(List<int> daysSelected) {
    if (daysSelected.length == 1) {
      return _dayToString(daysSelected[0]);
    } else {
      daysSelected.sort();
      daysSelected.removeAt(0);
      List<String> shortedDays =
          daysSelected.map((day) => _dayToString(day).substring(0, 3)).toList();

      return shortedDays.join(", ");
    }
  }
}
