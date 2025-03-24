import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // Initialize the notification service
  Future<void> init() async {
    // Initialize timezone
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/New_York')); // Replace with your timezone.

    // Android initialization settings
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon'); //  Replace 'app_icon' with the name of your app's icon in the `android/app/src/main/res/drawable` folder.

    // iOS initialization settings (you can customize these if needed)
    //const DarwinInitializationSettings initializationSettingsIOS =
    //    DarwinInitializationSettings(
    //  requestAlertPermission: true,
    //  requestBadgePermission: true,
    //  requestSoundPermission: true,
    //);

    // Combine initialization settings
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    //    iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: (String? payload) async {
          if (payload != null) {
            print('notification payload: $payload');
          }
          // Handle notification tap (e.g., navigate to a specific screen)
        });
  }

  // Show a simple notification
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your_channel_id', 'Your Channel Name',
        channelDescription: 'Description of your channel',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails,
        payload: payload);
  }

  // Show a daily notification at 10 AM
  Future<void> showDailyNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0, // Notification ID
      'Daily Step Reminder', // Title
      'Remember to take a walk and stay healthy!', // Body
      _nextInstanceOfTenAM(), // Schedule for 10 AM daily
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder_channel_id', // Channel ID
          'Daily Reminder Channel', // Channel Name
          channelDescription: 'Channel for daily step reminders', // Channel Description
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
          ticker: 'ticker',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, // Ensure the time is matched
    );
  }

  tz.TZDateTime _nextInstanceOfTenAM() {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledTime = tz.TZDateTime(tz.local, now.year, now.month, now.day, 10); // 10:00 AM
    if (scheduledTime.isBefore(now) || scheduledTime.isAtSameMomentAs(now)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }
    return scheduledTime;
  }

  // Cancel a specific notification
  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  // Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

