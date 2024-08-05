import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recurring_alarm/core/constant.dart';
import 'package:recurring_alarm/presentation/reminder/viewmodels/reminder_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReminderTypeSelection extends ConsumerWidget {
  const ReminderTypeSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: SegmentedButton(
          emptySelectionAllowed: false,
          showSelectedIcon: false,
          segments: [
            ButtonSegment(
              value: ReminderType.daily,
              label: FittedBox(
                  child: Text(
                AppLocalizations.of(context)!.daily,
              )),
            ),
            ButtonSegment(
              value: ReminderType.weekly,
              label:
                  FittedBox(child: Text(AppLocalizations.of(context)!.weekly)),
            ),
            ButtonSegment(
              value: ReminderType.monthly,
              label:
                  FittedBox(child: Text(AppLocalizations.of(context)!.monthly)),
            ),
          ],
          onSelectionChanged: (Set<ReminderType> newSelection) {
            ref
                .read(reminderViewModel.notifier)
                .setReminderType(newSelection.first);
          },
          selected: <ReminderType>{ref.watch(reminderViewModel).reminderType}),
    );
  }
}
