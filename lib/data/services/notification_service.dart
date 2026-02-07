import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

/// Background message handler - must be a top-level function
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Background message received: ${message.notification?.title}');
}

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static String? _fcmToken;

  /// Get FCM Token (used for sending targeted notifications)
  static String? get fcmToken => _fcmToken;

  /// Initialize Firebase Messaging
  static Future<void> init() async {
    // Request permission (iOS)
    final settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint('Notification permission: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      // Register background handler
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      // Listen for foreground messages
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

      // Handle notification tap when app was in background
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

      // Get FCM Token (with iOS APNs handling)
      await _initializeToken();

      // Listen for token refresh
      _messaging.onTokenRefresh.listen((newToken) {
        _fcmToken = newToken;
        debugPrint('FCM Token refreshed: $newToken');
      });
    }
  }

  /// Initialize FCM token with iOS APNs handling
  static Future<void> _initializeToken() async {
    try {
      // On iOS, we need to wait for APNs token first
      // On iOS, we need to wait for APNs token first
      if (Platform.isIOS) {
        // try-catch specific for APNs to avoid crashing if capability is missing
        try {
          String? apnsToken = await _messaging.getAPNSToken();

          // If APNs token is not ready, wait and retry
          if (apnsToken == null) {
            debugPrint('Waiting for APNs token...');
            await Future.delayed(const Duration(seconds: 3));
            apnsToken = await _messaging.getAPNSToken();
          }

          if (apnsToken == null) {
            debugPrint(
                'APNs token not available. Push notifications will NOT work on this device (No Capability/Sim).');
            return;
          }
          debugPrint('APNs Token received: ${apnsToken.substring(0, 20)}...');
        } catch (e) {
          debugPrint(
              'Failed to get APNs token (likely missing Push Capability): $e');
          return;
        }
      }

      // Now get FCM token
      _fcmToken = await _messaging.getToken();
      debugPrint('FCM Token: $_fcmToken');
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
      // On iOS Simulator, this is expected to fail
      if (Platform.isIOS) {
        debugPrint('Note: Push notifications may not work on iOS Simulator.');
      }
    }
  }

  /// Handle messages when app is in foreground
  static void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('Foreground message: ${message.notification?.title}');
    // The message will be shown automatically by system on Android 13+
  }

  /// Handle notification tap when app was in background/terminated
  static void _handleMessageOpenedApp(RemoteMessage message) {
    debugPrint('Message opened app: ${message.notification?.title}');
    // Navigate to specific screen based on message data if needed
  }

  /// Subscribe to a topic (optional, for broadcast notifications)
  static Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
    debugPrint('Subscribed to topic: $topic');
  }

  /// Unsubscribe from a topic
  static Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
    debugPrint('Unsubscribed from topic: $topic');
  }
}
