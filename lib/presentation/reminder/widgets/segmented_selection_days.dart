import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:recurring_alarm/localization/string_hardcoded.dart';
import 'package:recurring_alarm/presentation/reminder/viewmodels/reminder_view_model.dart';

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
            label: FittedBox(child: Text('M'.hardcoded)),
          ),
          ButtonSegment(
            value: 2,
            label: FittedBox(child: Text('T'.hardcoded)),
          ),
          ButtonSegment(
            value: 3,
            label: FittedBox(child: Text('W'.hardcoded)),
          ),
          ButtonSegment(
            value: 4,
            label: FittedBox(child: Text('T'.hardcoded)),
          ),
          ButtonSegment(
            value: 5,
            label: FittedBox(child: Text('F'.hardcoded)),
          ),
          ButtonSegment(
            value: 6,
            label: FittedBox(child: Text('S'.hardcoded)),
          ),
          ButtonSegment(
            value: 7,
            label: FittedBox(child: Text('S'.hardcoded)),
          ),
        ],
        selected: Set.from(ref.watch(reminderViewModel).daysSelected),
        onSelectionChanged: (newSelection) {
          FocusScope.of(context).unfocus();

          ref.read(reminderViewModel.notifier).setDaysSelected(newSelection);
        },
      ),
    );
  }
}
