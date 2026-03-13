import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService extends GetxService {
  // Instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  // Initialize the service
  Future<NotificationService> init() async {
    // 1. Setup Android initialization settings
    // '@mipmap/ic_launcher' refers to the default app icon. 
    // Make sure you have an icon in android/app/src/main/res/drawable if you use a custom name.
    const AndroidInitializationSettings androidSettings = 
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // 2. Setup iOS/macOS initialization settings
    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // 3. Combine settings
    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    // 4. Initialize the plugin
    await _notificationsPlugin.initialize(initSettings);
    
    return this; // Return the initialized service
  }

  // Method to show a simple notification
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    // Define Android specific details
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'simple_notification_channel', // Channel ID
      'Simple Notifications', // Channel Name
      channelDescription: 'This channel is for simple notifications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    // Define iOS specific details
    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    // Combine platform specific details
    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    // Show the notification
    await _notificationsPlugin.show(
      id,
      title,
      body,
      platformDetails,
    );
  }
}