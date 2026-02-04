import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jovera_finance/screens/auth/onboarding/model/on_boarding_model.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/view/bottom_navigation_bar_view.dart';
import 'package:jovera_finance/utilities/services/notification_service.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';

class OnBoardingState {
  const OnBoardingState({
    required this.pageController,
    required this.storage,
    this.currentPage = 0,
  });

  final PageController pageController;
  final int currentPage;
  final GetStorage storage;

  OnBoardingState copyWith({PageController? pageController, int? currentPage}) {
    return OnBoardingState(
      pageController: pageController ?? this.pageController,
      storage: storage,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class OnBoardingController extends StateNotifier<OnBoardingState> {
  OnBoardingController(this.ref)
    : super(
        OnBoardingState(
          pageController: PageController(),
          storage: GetStorage(),
        ),
      );

  final Ref ref;
  PageController get pageController => state.pageController;
  int get currentPage => state.currentPage;
  GetStorage get storage => state.storage;

  set currentPage(int value) {
    state = state.copyWith(currentPage: value);
  }

  saveFirstTime() async {
    await storage.write("first_time", true);
  }

  Future<void> next() async {
    if (currentPage > onBoardingList.length - 2) {
      skip();
    } else {
      currentPage = currentPage + 1;
      await pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> skip() async {
    await ref.read(notificationServiceProvider).init();
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    await saveFirstTime();
    AppNavigator.pushAndRemoveUntil(BottomnavigationBarView());
  }

  void onPageChanged(int index) {
    currentPage = index;
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

final onBoardingControllerProvider =
    StateNotifierProvider<OnBoardingController, OnBoardingState>((ref) {
  return OnBoardingController(ref);
});

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
    'Apply for a loan',
    "assets/images/onboarding1.svg",
    'Follow our quick steps process within\nthe app to apply for a loan',
  ),
  OnBoardingModel(
    'Your loan is disbursed',
    "assets/images/onboarding2.svg",
    'Once your request is approved,  your\nloan is disbursed',
  ),
  OnBoardingModel(
    'Cash easily',
    "assets/images/onboarding3.svg",
    'Once your loan is approved you can\ncash at the nearest ATM',
  ),
];
