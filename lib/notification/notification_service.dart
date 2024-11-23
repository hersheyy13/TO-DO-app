import 'package:flutter/src/material/colors.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  List<String> _notifications = []; // List to hold notifications

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('appicon.png'); // Replace with your app icon

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> showNotification(int id, String title, String body, {required MaterialColor Color}) async {
    // Store the notification
    _notifications.add('$title: $body');
    if (_notifications.length > 20) {
      _notifications.removeAt(0); // Limit to the last 20 notifications
    }

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id', // Replace with your channel ID
      'your_channel_name', // Replace with your channel name
      channelDescription: 'your_channel_description', // Replace with your channel description
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  List<String> getNotifications() {
    return _notifications; // Return the list of notifications
  }
}
