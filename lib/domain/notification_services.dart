import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:recurring_alarm/domain/entities/notification_reminder.dart';

class NotificationServices {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'flutter_schedule_app_channel',
          channelName: 'Flutter Schedule App Channel',
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

  static Future<void> scheduleNotification({
    required NotificationReminder reminder,
  }) async {
    await AwesomeNotifications()
        .createNotification(
          content: NotificationContent(
            groupKey: reminder.uuid.toString(),
            id: -1,
            channelKey: 'flutter_schedule_app_channel',
            title: "You have a reminder !",
            body: reminder.task,
            category: NotificationCategory.Alarm,
            notificationLayout: NotificationLayout.BigText,
            locked: true,
            wakeUpScreen: true,
            actionType: ActionType.KeepOnTop,
            autoDismissible: false,
            fullScreenIntent: true,
            backgroundColor: Colors.transparent,
          ),
          schedule: NotificationCalendar(
            minute: reminder.time.minute,
            hour: reminder.time.hour,
            day: reminder.date.day,
            weekday: reminder.date.weekday,
            month: reminder.date.month,
            year: reminder.date.year,
            preciseAlarm: true,
            allowWhileIdle: true,
            timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
          ),
        )
        .then((value) => print(
            'notification create for ${reminder.time} at ${reminder.date.day}/${reminder.date.month}/${reminder.date.year} '));
  }

  static Future<void> cancelScheduledNotifications(int id) async {
    print("cancel notification for $id");
    //await AwesomeNotifications().cancelSchedule(id);
    await AwesomeNotifications().cancelNotificationsByGroupKey(id.toString());
  }
}
