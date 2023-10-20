import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recurring_alarm/presentation/reminder/viewmodels/reminder_view_model.dart';
import 'package:recurring_alarm/presentation/reminder/widgets/landing/reminder_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:recurring_alarm/routing/app_routes.dart';

class LandingScreen extends ConsumerWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reminderProviderWatch = ref.watch(reminderViewModel);
    return Scaffold(
        appBar: AppBar(title: const Text("Reminders"), actions: [
          IconButton(
              onPressed: () => context.pushNamed(AppRoute.settings.name),
              icon: const Icon(Icons.settings)),
        ]),
        floatingActionButton: FloatingActionButton(
            onPressed: () =>
                ref.read(reminderViewModel.notifier).openAddReminder(context),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            )),
        body: reminderProviderWatch.reminders.when(
            data: (reminder) {
              return SafeArea(
                child: Stack(
                  children: [
                    (reminder.isNotEmpty || reminderProviderWatch.loading)
                        ? ListView.builder(
                            padding: const EdgeInsets.only(bottom: 80, top: 0),
                            itemCount: reminder.length,
                            itemBuilder: (context, index) =>
                                ReminderCard(reminder: reminder[index]),
                          )
                        : Center(
                            child: Text(
                                AppLocalizations.of(context)!.noReminders)),
                    if (reminderProviderWatch.loading)
                      const Align(
                        alignment: Alignment.topCenter,
                        child: LinearProgressIndicator(),
                      ),
                  ],
                ),
              );
            },
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            loading: () => const SizedBox.shrink()));
  }
}
