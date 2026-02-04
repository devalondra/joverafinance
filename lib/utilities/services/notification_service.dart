import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:jovera_finance/screens/main_drawer/notification/view/notification_view.dart';
import 'package:jovera_finance/screens/main_drawer/notification/controller/notification_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_strings.dart';
import 'package:jovera_finance/utilities/navigation/app_messenger.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';
import 'package:socket_io_client/socket_io_client.dart' as i_o;

class NotificationService {
  NotificationService(this.ref);

  final Ref ref;
  late i_o.Socket socket;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  bool _socketInitialized = false;

  i_o.Socket get socketInstance => socket;
  bool get isSocketInitialized => _socketInitialized;

  Future<NotificationService> init() async {
    await initFirebaseNotification();
    initSocketConnection();
    return this;
  }

  Future<bool> areNotificationsEnabled() async {
    final settings = await FirebaseMessaging.instance.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  /// Initialize Firebase Push Notifications
  Future<void> initFirebaseNotification() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      _firebaseMessaging.getToken().then((token) {});
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      handleMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleNotificationTap(message);
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      handleMessage(message);
    });

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  void handleNotificationTap(RemoteMessage message) async {
    await ref.read(notificationControllerProvider.notifier).getNotifications();
    ref.read(bottomNavigationBarControllerProvider.notifier).setIndex(0);
    AppNavigator.push(const NotificationView());
  }

  void handleMessage(RemoteMessage? message, {bool fromTapped = false}) async {
    if (message == null) return;

    if (fromTapped) {
      AppNavigator.push(const NotificationView());
      await ref.read(notificationControllerProvider.notifier).getNotifications();
      return;
    }

    final snackBar = SnackBar(
      content: Text(
        message.notification?.body ?? "You have a new notification!",
        style: const TextStyle(color: AppColors.white),
      ),
      backgroundColor: AppColors.black2,
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'View',
        textColor: Colors.white,
        onPressed: () {
          AppNavigator.push(const NotificationView());
        },
      ),
    );
    AppMessenger.showSnackBar(snackBar);
  }

  void initSocketConnection() {
    final AuthState authState = ref.read(authManagerProvider);
    final AuthManager authManager = ref.read(authManagerProvider.notifier);
    if (authState.isLogged) {
      if (_socketInitialized) return;

      socket = i_o.io(
        '$baseURL/',
        i_o.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setAuth({'token': authManager.getToken()})
            .build(),
      );

      socket.connect();

      socket.onConnect((_) {
        debugPrint('🟢 Socket connected');

        socket.emit('identify', {'clientId': authManager.currentUser.id});
        debugPrint('🟢 user identified');
        _socketInitialized = true;
        socket.off('new_notification');
        socket.on('new_notification', (data) async {
          debugPrint('📩 Socket notification: $data');
          await ref
              .read(notificationControllerProvider.notifier)
              .refreshNotifications();
          final body = data['message'] ?? data.toString();

          AppMessenger.showSnackBar(
            SnackBar(
              content: Text(body, style: const TextStyle(color: Colors.white)),
              duration: const Duration(seconds: 3),
              backgroundColor: AppColors.black2,
              behavior: SnackBarBehavior.floating,
              action: SnackBarAction(
                label: 'View',
                textColor: Colors.white,
                onPressed: () async {
                  AppNavigator.push(const NotificationView());
                },
              ),
            ),
          );
        });

        socket.off('chat:message');
        socket.on('chat:message', (data) {
          if (kDebugMode) print(data);
          AppMessenger.showSnackBar(
            SnackBar(
              content: Text(
                data['text'] ?? "New message received",
                style: const TextStyle(color: Colors.white),
              ),
              duration: const Duration(seconds: 3),
              backgroundColor: AppColors.black2,
              behavior: SnackBarBehavior.floating,
              action: SnackBarAction(
                label: 'View',
                textColor: Colors.white,
                onPressed: () {
                  ref
                      .read(bottomNavigationBarControllerProvider.notifier)
                      .setIndex(3);
                },
              ),
            ),
          );
        });
      });
      socket.onDisconnect((_) {
        debugPrint('Socket disconnected');
      });
    }
  }
}

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService(ref);
});

@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("🔁 Background message received: ${message.messageId}");
}
