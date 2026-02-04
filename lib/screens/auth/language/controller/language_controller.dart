import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/auth/app_permissions/view/app_permissions_view.dart';
import 'package:jovera_finance/utilities/localization/locale_controller.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';

class LanguageState {
  const LanguageState({this.firstTime, this.selectedLanguage = ''});

  final bool? firstTime;
  final String selectedLanguage;

  LanguageState copyWith({bool? firstTime, String? selectedLanguage}) {
    return LanguageState(
      firstTime: firstTime ?? this.firstTime,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }
}

class LanguageController extends StateNotifier<LanguageState> {
  LanguageController(this.ref) : super(const LanguageState()) {
    state = state.copyWith(
      selectedLanguage: ref.read(localeControllerProvider).toString(),
    );
  }

  final Ref ref;

  bool? get firstTime => state.firstTime;
  String get selectedLanguage => state.selectedLanguage;

  void changeLanguage(String languageCode) {
    ref.read(localeControllerProvider.notifier).setLocale(languageCode);
    state = state.copyWith(selectedLanguage: languageCode);
    AppNavigator.push(const AppPermissionsView());
    // Get.offAll(() => OnboardingView(), binding: OnboardingBinding());
  }

}

final languageControllerProvider =
    StateNotifierProvider<LanguageController, LanguageState>((ref) {
  return LanguageController(ref);
});
