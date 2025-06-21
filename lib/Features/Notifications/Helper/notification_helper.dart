import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:time_food/Features/Notifications/Helper/local_notification.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  static void scheduleNotificationAfter24Hours(
    context,
    productName,
    productId,
  ) async {
    await flutterLocalNotificationsPlugin.cancel(1001);

    // 1. Android-specific notification details
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'sse_notifications_channel',
          'SSE Notifications',
          channelDescription: 'Send Notification Before 24h',
          importance: Importance.max,
          priority: Priority.high,
          styleInformation: DefaultStyleInformation(true, true),
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    // 4. Schedule the notification
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.zonedSchedule(
      1,
      "تنبيه هام",
      "${productName} علي وشك ان ينتهي صلاحيته بعد 24 ساعة الرجاء التخلص منه في اقرب وقتك حفاظا علي سلامتك.",
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,

      payload: 'product Expire',
    );
  }
}
