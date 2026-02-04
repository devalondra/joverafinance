import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jovera_finance/screens/auth/onboarding/view/onboarding_view.dart';
import 'package:jovera_finance/utilities/services/notification_service.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';

class AppPermissionsState {
  const AppPermissionsState({
    required this.storage,
    this.showPermissionButton = false,
  });

  final bool showPermissionButton;
  final GetStorage storage;

  AppPermissionsState copyWith({bool? showPermissionButton}) {
    return AppPermissionsState(
      storage: storage,
      showPermissionButton: showPermissionButton ?? this.showPermissionButton,
    );
  }
}

class AppPermissionsController extends StateNotifier<AppPermissionsState> {
  AppPermissionsController(this.ref)
    : super(AppPermissionsState(storage: GetStorage()));

  final Ref ref;

  bool get showPermissionButton => state.showPermissionButton;
  set showPermissionButton(bool value) {
    state = state.copyWith(showPermissionButton: value);
  }

  GetStorage get storage => state.storage;

  goToLogin() async {
    await ref.read(notificationServiceProvider).init();
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    AppNavigator.pushReplacement(const OnboardingView());
  }
}

// final appPermissionsControllerProvider =
//     StateNotifierProvider<AppPermissionsController, AppPermissionsState>((ref) {
//   return AppPermissionsController(ref);
// });
final appPermissionsControllerProvider =
    StateNotifierProvider<AppPermissionsController, AppPermissionsState>((ref) {
      return AppPermissionsController(ref);
    });
