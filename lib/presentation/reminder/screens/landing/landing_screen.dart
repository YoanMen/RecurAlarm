import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recurring_alarm/presentation/reminder/viewmodels/reminder_view_model.dart';
import 'package:recurring_alarm/presentation/reminder/widgets/landing/reminder_card.dart';

class LandingScreen extends ConsumerWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reminderProviderWatch = ref.watch(reminderViewModel);
    final reminderProviderRead = ref.read(reminderViewModel.notifier);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => ref
              .read(reminderViewModel.notifier)
              .openAddReminder(context), // * Open Add Reminder
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      appBar: AppBar(
        forceMaterialTransparency: true,
        actions: [
          IconButton(
              onPressed: () => reminderProviderRead.deleteAll(),
              icon: const Icon(Icons.settings))
        ],
      ),
      body: reminderProviderWatch.reminders.when(
        data: (reminder) {
          return Stack(
            children: [
              (reminder.isNotEmpty)
                  ? ListView.builder(
                      padding: const EdgeInsets.only(bottom: 80),
                      itemCount: reminder.length,
                      itemBuilder: (context, index) =>
                          ReminderCard(reminder: reminder[index]),
                    )
                  : const Center(child: Text("No reminders")),
              if (reminderProviderWatch.loading)
                const Align(
                  alignment: Alignment.topCenter,
                  child: LinearProgressIndicator(),
                ),
            ],
          );
        },
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => const Align(
          alignment: Alignment.topCenter,
          child: LinearProgressIndicator(),
        ),
      ),
    );
  }
}
