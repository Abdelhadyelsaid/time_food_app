import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../Recipes/View/saved_food_screen.dart';

///This function for initializing local notifications

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> initLocalNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
   AndroidInitializationSettings('@mipmap/ic_launcher');


  final DarwinInitializationSettings initializationSettingsDarwin =
  DarwinInitializationSettings(
    notificationCategories: [
      DarwinNotificationCategory(
        'demoCategory',
        actions: <DarwinNotificationAction>[
          DarwinNotificationAction.plain('id_1', 'Action 1'),
          DarwinNotificationAction.plain(
            'id_2',
            'Action 2',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.destructive,
            },
          ),
          DarwinNotificationAction.plain(
            'id_3',
            'Action 3',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.foreground,
            },
          ),
        ],
        options: <DarwinNotificationCategoryOption>{
          DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
        },
      )
    ],
  );

  InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        if (notificationResponse.payload != null) {
          handleNotificationTap(notificationResponse.payload!);
        }
      }, onDidReceiveBackgroundNotificationResponse: backgroundNotificationHandler);
}

@pragma('vm:entry-point')
void backgroundNotificationHandler(NotificationResponse notificationResponse) {
  if (notificationResponse.payload != null) {
    handleNotificationTap(notificationResponse.payload!);
  }
}

void handleNotificationTap(String payload) {
   final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  navigatorKey.currentState?.push(
    MaterialPageRoute(
      builder: (context) => SavedFoodScreen(),
    ),
  );
}

