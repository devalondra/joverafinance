
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/binding/bottom_navigation_bar_binding.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/view/bottom_navigation_bar_view.dart';
import 'package:jovera_finance/screens/main_drawer/notification/model/notification_model.dart';
import 'package:jovera_finance/screens/main_drawer/notification/provider/notification_provider.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/widgets/app_loading_controller.dart';

class NotificationController extends GetxController {
  AppLoadingController appLoadingController = AppLoadingController();
  RxList<NotificationModel> notificationList = <NotificationModel>[].obs;
  final ScrollController scrollController = ScrollController();
  RxBool hasUnreadNotifications = false.obs;
  RxString uploadDocument = ''.obs;
  RxInt currentPage = 1.obs;
  RxInt totalPages = 1.obs;
  RxBool isLoading = false.obs;
  RxBool nextPage = false.obs;
  @override
  onInit() async {
    super.onInit();
    await getNotifications();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          currentPage < totalPages.value &&
          !isLoading.value) {
        getNotifications();
      }
    });
  }






  notificationOnTap(index) {
    if (!notificationList[index].isRead!) {
      readNotification(notificationList[index].id);
    }
    if (notificationList[index].title!.startsWith("Document Requested")) {
      // Get.to(
      //   () => UploadNewDocumentView(
      //     applicantId: notificationList[index].data!["applicantId"] ?? "",
      //     field: notificationList[index].data!["field"] ?? "",
      //   ),
      // );
    } else if (notificationList[index].title!.startsWith("New Message") ||
        notificationList[index].title!.startsWith("New message") ||
        notificationList[index].title!.startsWith("new message")) {
      Get.offAll(
        () => BottomnavigationBarView(),
        binding: BottomNavigationBarBinding(),
      );
      BottomNavigationBarController cont = Get.put(
        BottomNavigationBarController(),
      );
      cont.selectedIndex.value = 3;
    } else {
      Get.offAll(
        () => BottomnavigationBarView(),
        binding: BottomNavigationBarBinding(),
      );
      BottomNavigationBarController cont = Get.put(
        BottomNavigationBarController(),
      );
      cont.selectedIndex.value = 4;
    }
  }

  Future<void> refreshNotifications() async {
    notificationList.clear();
    currentPage.value = 1;
    nextPage.value = false;
    await getNotifications();
  }

  Future<void> getNotifications() async {
    if (isLoading.value) return;
    isLoading.value = true;
    final int pageToFetch =
        nextPage.value ? currentPage.value + 1 : currentPage.value;

    NotificationsProvider().getNotifications(
      page: pageToFetch,
      beforeSend: () {
        if (!nextPage.value) appLoadingController.loading();
      },
      onSuccess: (response) {
        isLoading.value = false;
        appLoadingController.stop();
        print(response);
        if (response.data != null) {
          final List<NotificationModel> fetchedNotifications =
              response.data['notifications']
                  .map<NotificationModel>((x) => NotificationModel.fromJson(x))
                  .toList();

          notificationList.addAll(fetchedNotifications);
          notificationList.refresh();
          //todo
          // totalPages.value = response.data['pagination']["totalPages"];
          // currentPage.value = response.data['pagination']["currentPage"];
          // nextPage.value = response.data['pagination']["hasNextPage"];
          hasUnreadNotifications.value = notificationList.any(
            (n) => n.isRead == false,
          );
        }
      },
      onError: (error) {
        appLoadingController.stop();
        print(error.message);
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
        notificationList.clear();
        currentPage.value = 0;

        nextPage.value = true;
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
    isLoading.value = true;

    NotificationsProvider().readAllNotifications(
      beforeSend: () {
        appLoadingController.loading();
      },
      onSuccess: (response) {
        isLoading.value = false;
        appLoadingController.stop();
        notificationList.clear();
        currentPage.value = 0;

        nextPage.value = true;
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
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
