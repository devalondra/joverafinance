import Flutter
import UIKit
import Firebase
import FirebaseMessaging

@main
@objc class AppDelegate: FlutterAppDelegate, MessagingDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    if FirebaseApp.app() == nil {
    FirebaseApp.configure()
    }
    UNUserNotificationCenter.current().delegate = self
    Messaging.messaging().delegate = self
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
