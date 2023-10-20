import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:intl/intl.dart';
import 'package:recurring_alarm/domain/entities/notification_reminder.dart';

class NotificationServices {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      null,
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
          playSound: true,
        ),
      ],
    );
  }

  static Future<void> scheduleNotification(
      {required NotificationReminder reminder, required int id}) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          groupKey: reminder.uuid.toString(),
          id: reminder.uuid + id,
          channelKey: 'recurring_alarm_app_channel',
          title: "${DateFormat.jm().format(reminder.date)} reminder",
          body: reminder.task,
          category: NotificationCategory.Alarm,
          notificationLayout: NotificationLayout.Default,
          locked: false,
          wakeUpScreen: true,
          actionType: ActionType.KeepOnTop,
          autoDismissible: false,
          fullScreenIntent: true,
          backgroundColor: Colors.transparent,
          payload: {'uuid': 'notificationDelivred'},
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
        localizations: {
          "fr-fr": NotificationLocalization(
            title: "${DateFormat.Hm("fr").format(reminder.date)} rappel",
          ),
        }).then(
        (value) => debugPrint("Notification created for ${reminder.date}"));
  }

  static Future<void> cancelScheduledNotifications(int id) async {
    await AwesomeNotifications().cancelNotificationsByGroupKey(id.toString());
  }
}
