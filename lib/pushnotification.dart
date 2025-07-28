import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Firebasemsg {
  final FirebaseMessaging msgService = FirebaseMessaging.instance;

  Future<void> initFCM() async {
    // 1. Request notification permission
    NotificationSettings settings = await msgService.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await msgService.getToken();
      print(' FCM Token: $token');
    } else {
      print('Notification permission not granted');
    }

    // 2. Init local notifications
    await _initializeLocalNotifications();

    // 3. Handle foreground messages with custom display
    FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
      print(' Notification received: ${msg.notification?.title}');
      showLocalNotification(msg);
    });

    // 4. Handle background messages
    FirebaseMessaging.onBackgroundMessage(handleNotification);
  }

  // Initialize flutter_local_notifications
  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings androidInitSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
    InitializationSettings(android: androidInitSettings);

    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  // Show a custom local notification
  void showLocalNotification(RemoteMessage msg) {
    RemoteNotification? notification = msg.notification;
    AndroidNotification? android = msg.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'water_channel_id', // channel ID
            'Water Reminders', // channel name
            channelDescription: 'Notifications for hydration reminders',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );
    }
  }
}

// Background notification handler (must be top-level)
Future<void> handleNotification(RemoteMessage msg) async {
  print(' Background notification received: ${msg.notification?.title}');
}

// Required singleton for flutter_local_notifications
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
