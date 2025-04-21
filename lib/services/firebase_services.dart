import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationManager {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Call this once during app startup
  static Future<void> initialize() async {
    // Request permissions (optional on Android)
    await _messaging.requestPermission();

    // 🔄 Handle token refresh
    _messaging.onTokenRefresh.listen(_updateTokenInFirestore);

    // 🔔 Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleMessage);

    // 📥 Handle background/terminated notification taps
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    // 🕐 Handle cold start (when app opened from terminated state via notification)
    RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // 🔽 Get initial token and store
    String? token = await _messaging.getToken();
    await _updateTokenInFirestore(token);
  }

  /// Log message content
  static void _handleMessage(RemoteMessage message) {
    print("🔔 Notification Received:");
    print("Title: ${message.notification?.title}");
    print("Body: ${message.notification?.body}");
    print("Data: ${message.data}");

    // Play custom sound if needed
    _playNotificationSound();
  }

  /// Update FCM token in Firestore
  static Future<void> _updateTokenInFirestore(String? token) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && token != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'fcm_token': token});
      print("✅ FCM token updated: $token");
    }
  }

  /// Play custom sound using assets
  static Future<void> _playNotificationSound() async {
    // try {
    //   final player = AudioPlayer(); // Requires audioplayers package
    //   await player.play(AssetSource('sounds/patrickuklar.mp3'));
    //   print("🔊 Played custom notification sound.");
    // } catch (e) {
    //   print("⚠️ Error playing sound: $e");
    // }
  }
}
