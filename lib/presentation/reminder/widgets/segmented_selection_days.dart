import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recurring_alarm/presentation/reminder/viewmodels/reminder_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<int> selectedDays = [];

class SegmentedSelectionDays extends ConsumerWidget {
  const SegmentedSelectionDays({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: SegmentedButton(
        emptySelectionAllowed: true,
        multiSelectionEnabled: true,
        showSelectedIcon: false,
        segments: [
          ButtonSegment(
            value: 1,
            label: FittedBox(
                child: Text(AppLocalizations.of(context)!.monday_letter)),
          ),
          ButtonSegment(
            value: 2,
            label: FittedBox(
                child: Text(AppLocalizations.of(context)!.tuesday_letter)),
          ),
          ButtonSegment(
            value: 3,
            label: FittedBox(
                child: Text(AppLocalizations.of(context)!.wednesday_letter)),
          ),
          ButtonSegment(
            value: 4,
            label: FittedBox(
                child: Text(AppLocalizations.of(context)!.thursday_letter)),
          ),
          ButtonSegment(
            value: 5,
            label: FittedBox(
                child: Text(AppLocalizations.of(context)!.friday_letter)),
          ),
          ButtonSegment(
            value: 6,
            label: FittedBox(
                child: Text(AppLocalizations.of(context)!.saturday_letter)),
          ),
          ButtonSegment(
            value: 7,
            label: FittedBox(
                child: Text(AppLocalizations.of(context)!.sunday_letter)),
          ),
        ],
        selected: Set.from(ref.watch(reminderViewModel).daysSelected),
        onSelectionChanged: (newSelection) {
          ref.read(reminderViewModel.notifier).setDaysSelected(newSelection);
        },
      ),
    );
  }
}
