import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/screens/main_drawer/notification/binding/notification_binding.dart';
import 'package:jovera_finance/screens/main_drawer/notification/controller/notification_controller.dart';
import 'package:jovera_finance/screens/main_drawer/notification/view/notification_view.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:socket_io_client/socket_io_client.dart' as i_o;

class NotificationService extends GetxService {
  late i_o.Socket socket;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final RxBool socketInitialized = false.obs;

  i_o.Socket get socketInstance => socket;
  bool get isSocketInitialized => socketInitialized.value;

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
    if (!Get.isRegistered<NotificationController>()) {
      NotificationBinding().dependencies();
      NotificationController cont = Get.find();
      await cont.getNotifications();
    }
    final BottomNavigationBarController bottomNavController = Get.find();
    bottomNavController.selectedIndex.value = 0;
    Get.to(() => const NotificationView(), binding: NotificationBinding());
  }

  void handleMessage(RemoteMessage? message, {bool fromTapped = false}) async {
    if (message == null) return;

    if (fromTapped) {
      Get.to(
        () => const NotificationView(),
        binding: NotificationBinding(),
        arguments: message.data,
      );
      if (Get.isRegistered<NotificationController>()) {
        final NotificationController cont = Get.find();
        cont.getNotifications();
      }
      return;
    }

    Get.snackbar(
      "Notification",
      message.notification?.body ?? "You have a new notification!",
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.black2,
      colorText: AppColors.white,
      onTap: (val) {
        Get.to(
          () => const NotificationView(),
          binding: NotificationBinding(),
          arguments: message.data,
        );
      },
    );
  }

  void initSocketConnection() {
    AuthManager authManager = Get.find();

    if (authManager.isLogged.value) {
   
      if (socketInitialized.value) return;

      socket = i_o.io(
        'https://0sbx6kf1-7000.inc1.devtunnels.ms/',

        i_o.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setAuth({'token': authManager.getToken()})
            .build(),
      );

      socket.connect();

      socket.onConnect((_) {
        debugPrint('🟢 Socket connected');

        socket.emit('identify', {'userId': authManager.appUser.value.id});
        debugPrint('🟢 user identified');
        socketInitialized.value = true;
        socket.off('new_notification');
        socket.on('new_notification', (data) async {
          debugPrint('📩 Socket notification: $data');
          await Get.find<NotificationController>().refreshNotifications();
          final body = data['message'] ?? data.toString();

          Get.snackbar(
            "Notification",
            body,

            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 3),
            backgroundColor: AppColors.black2,
            colorText: Colors.white,
            mainButton: TextButton(
              onPressed: () async {
                Get.to(() => NotificationView());
              },
              child: Text("View", style: TextStyle(color: Colors.white)),
            ),
          );
        });

        socket.off('receive_message');
        socket.on('receive_message', (data) {
          Get.snackbar(
            "Message",
            data["content"],

            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 3),
            backgroundColor: AppColors.black2,
            colorText: Colors.white,
            mainButton: TextButton(
              onPressed: () {
                Get.find<BottomNavigationBarController>().selectedIndex.value =
                    3;
              },
              child: Text("View", style: TextStyle(color: Colors.white)),
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

@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("🔁 Background message received: ${message.messageId}");
}
