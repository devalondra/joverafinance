import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jovera_finance/screens/auth/login/model/users.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/view/bottom_navigation_bar_view.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/utilities/authentication/cache_manager.dart';
import 'package:jovera_finance/utilities/constants/app_tools.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';
import 'package:jovera_finance/utilities/api/api_service.dart';
import 'package:jovera_finance/utilities/services/notification_service.dart';

class AuthState {
  const AuthState({this.appUser, this.isLogged = false});

  final AppUser? appUser;
  final bool isLogged;

  AuthState copyWith({AppUser? appUser, bool? isLogged}) {
    return AuthState(
      appUser: appUser ?? this.appUser,
      isLogged: isLogged ?? this.isLogged,
    );
  }
}

class AuthManager extends StateNotifier<AuthState> with CacheManager {
  AuthManager(this.ref) : super(const AuthState(appUser: null));

  final Ref ref;
  final GetStorage storage = GetStorage();

  AppUser get currentUser => state.appUser ?? AppUser();

  void setUser(AppUser user) {
    state = state.copyWith(appUser: user);
  }

  Future<void> logOut() async {
    if (state.isLogged) {
      state = state.copyWith(isLogged: false);
    }
    await storage.erase();
    await storage.write('first_time', true);

    final bottomNav = ref.read(bottomNavigationBarControllerProvider.notifier);
    bottomNav.isLogin = true;
    bottomNav.onItemTapped(0);

    AppNavigator.pushAndRemoveUntil(BottomnavigationBarView());
    Future.delayed(const Duration(seconds: 1), () {
      state = state.copyWith(appUser: AppUser());
    });
    appTools.showSuccessSnackBar('loggedOutSuccess', timer: 1);
  }

  void login() async {
    state = state.copyWith(isLogged: true);
    await saveToken(state.appUser?.token);
    ref.read(notificationServiceProvider).initSocketConnection();
  }

  Future<void> checkLoginStatus() async {
    final token = getToken();
    if (token != null) {
      state = state.copyWith(isLogged: true);
      await ref.read(apiServiceProvider).getUserDataByToken(token);
    }
  }
}

final authManagerProvider =
    StateNotifierProvider<AuthManager, AuthState>((ref) {
  return AuthManager(ref);
});
