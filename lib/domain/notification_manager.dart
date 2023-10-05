import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recurring_alarm/main.dart';
import 'package:timezone/standalone.dart';

class NotificationManager {
  static Future initializeNotification() async {
    await AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        'resource://drawable/res_app_icon',
        [
          NotificationChannel(
              channelGroupKey: 'basic_channel_group',
              channelKey: 'basic_channel',
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              defaultColor: const Color(0xFF9D50DD),
              ledColor: Colors.white)
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'high_importance_channel_group',
              channelGroupName: 'Basic group')
        ],
        debug: true);

    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    });

    await AwesomeNotifications().setListeners(
        onActionReceivedMethod: onActionReceivedMethod,
        onNotificationCreatedMethod: onNotificationCreatedMethod,
        onDismissActionReceivedMethod: onDismissActionReceivedMethod,
        onNotificationDisplayedMethod: onNotificationDisplayedMethod);
  }

  static Future onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("onNotificationReceivedMethod");
  }

  static Future onActionReceivedMethod(ReceivedAction receivedAction) async {
    debugPrint("onNotificationReceivedMethod");
    final payload = receivedAction.payload ?? {};
    if (payload["navigate"] == "true") {
      print("navigate");
    }
  }

  static Future onDismissActionReceivedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("onNotificationReceivedMethod");
  }

  static Future onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("onNotificationReceivedMethod");
  }

  static Future showNotification(
      {required String title,
      required String body,
      required String? summary,
      Map<String, dynamic>? payload,
      ActionType actionType = ActionType.KeepOnTop,
      NotificationLayout notificationLayout = NotificationLayout.Default,
      List<NotificationActionButton>? actionsButton}) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1,
        channelKey: "high_importance_channel",
        title: title,
        actionType: actionType,
        wakeUpScreen: true,
        notificationLayout: notificationLayout,
      ),
      actionButtons: actionsButton,
    );
  }
}
