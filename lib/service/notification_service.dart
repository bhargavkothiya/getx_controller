import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // जरूरी: Firebase initialize करना पड़ेगा background में
  await Firebase.initializeApp();

  print("Background Message: ${message.notification?.title}");
}

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.max,
  );

  static Future<void> initialize() async {
    try {
      // Background handler
      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );

      // Permission (Android 13+ + iOS)
      await _messaging.requestPermission(alert: true, badge: true, sound: true);

      // Local notification initialize
      await _localNotifications.initialize(
        settings: const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        ),
      );

      // Android 13+ runtime permission
      await _localNotifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();

      // Create notification channel
      await _localNotifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(_channel);

      // Foreground message
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        final notification = message.notification;

        if (notification != null) {
          _localNotifications.show(
            id: notification.hashCode,
            title: notification.title,
            body: notification.body,
            notificationDetails: NotificationDetails(
              android: AndroidNotificationDetails(
                _channel.id,
                _channel.name,
                importance: Importance.max,
                priority: Priority.high,
                icon: '@mipmap/ic_launcher',
              ),
            ),
          );
        }
      });

      // When user taps notification (background)
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        print("Notification clicked (background)");
      });

      // When app is opened from terminated state
      final initialMessage = await FirebaseMessaging.instance
          .getInitialMessage();

      if (initialMessage != null) {
        print("Opened from terminated state");
      }

      // Get FCM Token
      String? token = await _messaging.getToken();
      print("=========== FCM TOKEN ===========");
      print(token);
      print("=================================");
    } catch (e) {
      print("Notification Error: $e");
    }
  }
}
