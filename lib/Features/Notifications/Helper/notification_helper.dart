import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:time_food/Features/Notifications/Helper/local_notification.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  static void scheduleNotificationAfter24Hours(
      context,
      String productName,
      DateTime expireDate,
      ) async {
    await flutterLocalNotificationsPlugin.cancel(1001);

    // Android-specific notification details
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
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

    tz.initializeTimeZones();

    // 🧪 TEST MODE: Notify after 10 seconds
    final scheduledDate = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10));

    // ✅ REAL SCHEDULE: Uncomment this for actual 24-hour logic
    // final scheduledDate = tz.TZDateTime.from(expireDate, tz.local).subtract(const Duration(hours: 24));

    await flutterLocalNotificationsPlugin.zonedSchedule(
      1,
      "تنبيه هام",
      "$productName على وشك أن تنتهي صلاحيته خلال 24 ساعة. الرجاء التخلص منه في أقرب وقت حفاظًا على سلامتك.",
      scheduledDate,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: 'product_expire',
    );
  }
}
