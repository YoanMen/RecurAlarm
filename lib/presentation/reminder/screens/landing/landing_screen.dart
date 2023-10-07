import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recurring_alarm/localization/string_hardcoded.dart';
import 'package:recurring_alarm/presentation/reminder/viewmodels/reminder_view_model.dart';
import 'package:recurring_alarm/presentation/reminder/widgets/landing/reminder_card.dart';

class LandingScreen extends ConsumerWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reminderProviderWatch = ref.watch(reminderViewModel);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () =>
                ref.read(reminderViewModel.notifier).openAddReminder(context),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            )),
        appBar: AppBar(
          forceMaterialTransparency: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
          ],
        ),
        body: reminderProviderWatch.reminders.when(
            data: (reminder) {
              return Stack(
                children: [
                  (reminder.isNotEmpty || reminderProviderWatch.loading)
                      ? ListView.builder(
                          padding: const EdgeInsets.only(bottom: 80),
                          itemCount: reminder.length,
                          itemBuilder: (context, index) =>
                              ReminderCard(reminder: reminder[index]),
                        )
                      : Center(child: Text("No reminders".hardcoded)),
                  if (reminderProviderWatch.loading)
                    const Align(
                      alignment: Alignment.topCenter,
                      child: LinearProgressIndicator(),
                    ),
                ],
              );
            },
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            loading: () => const SizedBox.shrink()));
  }
}
