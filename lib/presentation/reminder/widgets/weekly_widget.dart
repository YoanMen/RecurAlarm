import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recurring_alarm/presentation/reminder/widgets/segmented_selection_days.dart';
import 'package:recurring_alarm/core/constant.dart';
import 'package:recurring_alarm/presentation/reminder/viewmodels/reminder_view_model.dart';

class WeeklyWidget extends ConsumerWidget {
  const WeeklyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reminderProviderWatch = ref.watch(reminderViewModel);
    final reminderProviderRead = ref.read(reminderViewModel.notifier);

    return Column(children: [
      const SizedBox(
        height: kDefaultPadding,
      ),
      const SegmentedSelectionDays(),
      const SizedBox(
        height: kDefaultPadding,
      ),
      SizedBox(
        width: double.infinity,
        child: SegmentedButton(
            emptySelectionAllowed: false,
            showSelectedIcon: false,
            segments: const [
              ButtonSegment(
                value: 0,
                label: FittedBox(child: Text("Every week")),
              ),
              ButtonSegment(
                value: 1,
                label: FittedBox(child: Text("Two weeks")),
              ),
              ButtonSegment(
                value: 2,
                label: FittedBox(child: Text('Three weeks')),
              ),
            ],
            onSelectionChanged: (Set<int> newSelection) {
              FocusScope.of(context).unfocus();

              reminderProviderRead.setlenghtSelected(newSelection.first);
            },
            selected: <int>{reminderProviderWatch.lenghtBetweenReminder}),
      ),
    ]);
  }
}
