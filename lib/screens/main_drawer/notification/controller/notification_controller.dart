
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/view/bottom_navigation_bar_view.dart';
import 'package:jovera_finance/screens/main_drawer/notification/model/notification_model.dart';
import 'package:jovera_finance/screens/main_drawer/notification/provider/notification_provider.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/constants/app_tools.dart';
import 'package:jovera_finance/widgets/app_loading_controller.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';

class NotificationState {
  const NotificationState({
    required this.appLoadingController,
    required this.notificationList,
    required this.scrollController,
    this.hasUnreadNotifications = false,
    this.uploadDocument = '',
    this.currentPage = 1,
    this.totalPages = 1,
    this.isLoading = false,
    this.nextPage = false,
  });

  final AppLoadingController appLoadingController;
  final List<NotificationModel> notificationList;
  final ScrollController scrollController;
  final bool hasUnreadNotifications;
  final String uploadDocument;
  final int currentPage;
  final int totalPages;
  final bool isLoading;
  final bool nextPage;

  NotificationState copyWith({
    List<NotificationModel>? notificationList,
    bool? hasUnreadNotifications,
    String? uploadDocument,
    int? currentPage,
    int? totalPages,
    bool? isLoading,
    bool? nextPage,
  }) {
    return NotificationState(
      appLoadingController: appLoadingController,
      notificationList: notificationList ?? this.notificationList,
      scrollController: scrollController,
      hasUnreadNotifications:
          hasUnreadNotifications ?? this.hasUnreadNotifications,
      uploadDocument: uploadDocument ?? this.uploadDocument,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      isLoading: isLoading ?? this.isLoading,
      nextPage: nextPage ?? this.nextPage,
    );
  }
}

class NotificationController extends StateNotifier<NotificationState> {
  NotificationController(this.ref)
    : super(
        NotificationState(
          appLoadingController: AppLoadingController(),
          notificationList: <NotificationModel>[],
          scrollController: ScrollController(),
        ),
      ) {
    _init();
  }

  final Ref ref;
  AppLoadingController get appLoadingController => state.appLoadingController;
  List<NotificationModel> get notificationList => state.notificationList;
  set notificationList(List<NotificationModel> value) =>
      state = state.copyWith(notificationList: value);
  ScrollController get scrollController => state.scrollController;
  bool get hasUnreadNotifications => state.hasUnreadNotifications;
  set hasUnreadNotifications(bool value) =>
      state = state.copyWith(hasUnreadNotifications: value);
  String get uploadDocument => state.uploadDocument;
  set uploadDocument(String value) =>
      state = state.copyWith(uploadDocument: value);
  int get currentPage => state.currentPage;
  set currentPage(int value) => state = state.copyWith(currentPage: value);
  int get totalPages => state.totalPages;
  set totalPages(int value) => state = state.copyWith(totalPages: value);
  bool get isLoading => state.isLoading;
  set isLoading(bool value) => state = state.copyWith(isLoading: value);
  bool get nextPage => state.nextPage;
  set nextPage(bool value) => state = state.copyWith(nextPage: value);

  Future<void> _init() async {
    await getNotifications();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          currentPage < totalPages &&
          !isLoading) {
        getNotifications();
      }
    });
  }






  notificationOnTap(index) {
    if (!notificationList[index].isRead!) {
      readNotification(notificationList[index].id);
    }
   if (notificationList[index].title!.startsWith("New Message") ||
        notificationList[index].title!.startsWith("New message") ||
        notificationList[index].title!.startsWith("new message")) {
      AppNavigator.pushAndRemoveUntil(const BottomnavigationBarView());
      ref.read(bottomNavigationBarControllerProvider.notifier).setIndex(3);
    } else {
      AppNavigator.pushAndRemoveUntil(const BottomnavigationBarView());
      ref.read(bottomNavigationBarControllerProvider.notifier).setIndex(4);
    }
  }

  Future<void> refreshNotifications() async {
    notificationList = <NotificationModel>[];
    currentPage = 1;
    nextPage = false;
    await getNotifications();
  }

  Future<void> getNotifications() async {
    if (!ref.read(authManagerProvider).isLogged) {
      return;
    }

    if (isLoading) return;
    isLoading = true;
    final int pageToFetch =
        nextPage ? currentPage + 1 : currentPage;

    NotificationsProvider().getNotifications(
      page: pageToFetch,
      beforeSend: () {
        if (!nextPage) appLoadingController.loading();
      },
      onSuccess: (response) {
        isLoading = false;
        appLoadingController.stop();
        if (kDebugMode) print(response);
        if (response.data != null) {
          final List<NotificationModel> fetchedNotifications =
              response.data['notifications']
                  .map<NotificationModel>((x) => NotificationModel.fromJson(x))
                  .toList();

          notificationList = <NotificationModel>[
            ...notificationList,
            ...fetchedNotifications,
          ];
          //todo
          // totalPages.value = response.data['pagination']["totalPages"];
          // currentPage.value = response.data['pagination']["currentPage"];
          // nextPage.value = response.data['pagination']["hasNextPage"];
          hasUnreadNotifications = notificationList.any(
            (n) => n.isRead == false,
          );
        }
      },
      onError: (error) {
        appLoadingController.stop();
        if (kDebugMode) print(error.message);
        appTools.showErrorSnackBar(
          appTools.errorMessage(error) ??
              'Opps, an error occurred during request, Please try again later',
          timer: 1,
        );
      },
    );
  }

  Future<void> readNotification(String? id) async {
    NotificationsProvider().readNotification(
      id: id,

      beforeSend: () {},
      onSuccess: (response) {
        appLoadingController.stop();
        notificationList = <NotificationModel>[];
        currentPage = 0;
        nextPage = true;
        getNotifications();
      },

      onError: (error) {
        appLoadingController.stop();
        appTools.showErrorSnackBar(
          appTools.errorMessage(error) ?? 'Opps, something went wrong',
          timer: 1,
        );
      },
    );
  }

  Future<void> readAllNotifications() async {
    isLoading = true;

    NotificationsProvider().readAllNotifications(
      beforeSend: () {
        appLoadingController.loading();
      },
      onSuccess: (response) {
        isLoading = false;
        appLoadingController.stop();
        notificationList = <NotificationModel>[];
        currentPage = 0;

        nextPage = true;
        getNotifications();
      },

      onError: (error) {
        appLoadingController.stop();
        appTools.showErrorSnackBar(
          appTools.errorMessage(error) ?? 'Opps, something went wrong',
          timer: 1,
        );
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    appLoadingController.dispose();
    super.dispose();
  }
}

final notificationControllerProvider =
    StateNotifierProvider<NotificationController, NotificationState>((ref) {
      return NotificationController(ref);
    });
