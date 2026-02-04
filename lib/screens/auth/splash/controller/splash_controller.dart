import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jovera_finance/screens/auth/language/view/language_view.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/view/bottom_navigation_bar_view.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/services/notification_service.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';

class SplashState {
  const SplashState({required this.storage, this.firstTime});

  final GetStorage storage;
  final bool? firstTime;

  SplashState copyWith({bool? firstTime}) {
    return SplashState(
      storage: storage,
      firstTime: firstTime ?? this.firstTime,
    );
  }
}

class SplashController extends StateNotifier<SplashState> {
  SplashController(this.ref)
    : super(SplashState(storage: GetStorage(), firstTime: null));

  final Ref ref;

  GetStorage get storage => state.storage;
  bool? get firstTime => state.firstTime;

  Future<void> initialize() async {
    state = state.copyWith(firstTime: await getFirstTime());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(authManagerProvider.notifier).checkLoginStatus();
      correctPage();
    });
  }

  Future correctPage() async {
    if (!firstTime!) {
      AppNavigator.pushReplacement(const LanguageView());
    } else {
      ref.read(notificationServiceProvider);
      AppNavigator.pushAndRemoveUntil(const BottomnavigationBarView());
    }
  }

  Future<bool> getFirstTime() async {
    return storage.read('first_time') ?? false;
  }
}

final splashControllerProvider =
    StateNotifierProvider<SplashController, SplashState>((ref) {
  return SplashController(ref);
});
