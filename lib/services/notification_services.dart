import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:intl/intl.dart';
import 'package:recurring_alarm/data/local/shared_preferences.dart';
import 'package:recurring_alarm/domain/entities/notification_reminder.dart';

class NotificationServices {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      "resource://drawable/notification_icon",
      [
        NotificationChannel(
          channelKey: 'recurring_alarm_app_channel',
          channelName: 'Recurring alarm App Channel',
          channelDescription:
              'This channel is resposible for showing Reminder App notifications.',
          importance: NotificationImportance.Max,
          defaultPrivacy: NotificationPrivacy.Public,
          defaultRingtoneType: DefaultRingtoneType.Alarm,
          defaultColor: Colors.transparent,
          locked: true,
          enableVibration: true,
          onlyAlertOnce:
              await SharedPreferencesManager().loadBoolSettings("alarmMode") ??
                  true,
          playSound: true,
        ),
      ],
    );
  }

  static Future<void> scheduleNotification(
      {required NotificationReminder reminder, required int id}) async {
    bool isAlarm =
        await SharedPreferencesManager().loadBoolSettings("alarmMode") ?? true;

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          groupKey: reminder.uuid.toString(),
          id: reminder.uuid + id,
          channelKey: 'recurring_alarm_app_channel',
          title: DateFormat.jm().format(reminder.date),
          body: reminder.task,
          category: isAlarm
              ? NotificationCategory.Alarm
              : NotificationCategory.Reminder,
          notificationLayout: NotificationLayout.Default,
          locked: true,
          wakeUpScreen: true,
          actionType: ActionType.KeepOnTop,
          autoDismissible: false,
          fullScreenIntent: true,
          backgroundColor: Colors.transparent,
        ),
        schedule: NotificationCalendar(
          minute: reminder.date.minute,
          hour: reminder.date.hour,
          day: reminder.date.day,
          weekday: reminder.date.weekday,
          month: reminder.date.month,
          year: reminder.date.year,
          preciseAlarm: true,
          allowWhileIdle: true,
        ),
        actionButtons: [
          NotificationActionButton(
              key: "clear-input",
              label: "CLEAR NOTIFICATION",
              showInCompactView: true,
              actionType: ActionType.DismissAction)
        ],
        localizations: {
          "fr-fr": NotificationLocalization(
            buttonLabels: {"clear-input": "EFFACER NOTIFICATION"},
            title: DateFormat.Hm("fr").format(reminder.date),
          ),
        });
  }

  static Future<void> cancelScheduledNotifications(String id) async {
    await AwesomeNotifications().cancelNotificationsByGroupKey(id.toString());
  }
}
