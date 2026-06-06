import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:url_launcher/url_launcher.dart';

/// Handles background Firebase messages.
///
/// Required by Firebase Messaging to process notifications
/// when the app is terminated or in background.
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();
  log("Background: ${message.notification?.title ?? 'No Title'}");
}

/// Service responsible for managing push notifications (FCM).
///
/// Handles:
/// - Notification initialization
/// - Permission requests
/// - Token retrieval
/// - Foreground/background message handling
/// - Deep linking via notification data
/// - Topic subscription (country-based filtering)
class NotificationService {
  /// Firebase Messaging instance
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  /// Opens URL from notification payload (if exists)
  static Future<void> _openUrl(RemoteMessage message) async {
    final url = message.data['url'];

    if (url != null && url.isNotEmpty) {
      final uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    }
  }

  /// Initializes Firebase messaging configuration
  ///
  /// Sets up:
  /// - Notification permissions
  /// - FCM token logging
  /// - Foreground message listener
  /// - Background message handler
  /// - Notification tap handling (foreground/terminated)
  static Future<void> init() async {
    await messaging.requestPermission();

    /// Get FCM device token
    String? token = await messaging.getToken();
    log("FCM Token: ${token ?? 'null'}");

    /// Background message handler registration
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    /// Handle notifications when app is in foreground
    FirebaseMessaging.onMessage.listen((message) {
      log("Foreground: ${message.notification?.title ?? 'No Title'}");
    });

    /// Handle notification tap when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _openUrl(message);
    });

    /// Handle notification tap when app is terminated
    RemoteMessage? initialMessage = await messaging.getInitialMessage();

    if (initialMessage != null) {
      Future.delayed(const Duration(seconds: 1), () {
        _openUrl(initialMessage);
      });
    }
  }

  /// Subscribes user to a country-based notification topic
  ///
  /// This allows sending targeted news notifications per country.
  static Future<void> subscribeToCountry(String? country) async {
    try {
      /// List of supported countries for notifications
      final countries = ['us', 'gb', 'de', 'fr', 'it', 'ru'];

      /// Unsubscribe from all country topics first
      for (final c in countries) {
        await messaging.unsubscribeFromTopic('news_$c');
      }

      /// Unsubscribe from global topic
      await messaging.unsubscribeFromTopic('news_all');

      /// Subscribe based on selected country
      if (country == null) {
        await messaging.subscribeToTopic('news_all');
      } else {
        await messaging.subscribeToTopic('news_$country');
      }
    } catch (e) {
      log("FCM Topic Error: $e");
    }
  }
}
