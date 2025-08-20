import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/main_drawer/notification/controller/notification_controller.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Column(
          children: [
            CustomPageTitle(
              back: true,
              notification: false,
              title: "Notifications".tr,
              suffix: InkWell(
                onTap: () {
                  controller.readAllNotifications();
                },
                child: MainText(
                  text: "Read All".tr,
                  color: AppColors.primary,
                  fontSize: 12,
                ),
              ),
            ).paddingSymmetric(horizontal: fullWidth * 0.03),

            SizedBox(height: fullHeight * 0.02),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                return RefreshIndicator.adaptive(
                  onRefresh: controller.refreshNotifications,
                  child:
                      controller.notificationList.isEmpty
                          ? ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: const [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 80),
                                  child: MainText(text: "No Notifications Yet"),
                                ),
                              ),
                            ],
                          )
                          : ListView.builder(
                            controller: controller.scrollController,
                            itemCount: controller.notificationList.length,
                            itemBuilder: (context, index) {
                              final item = controller.notificationList[index];
                              return ListTile(
                                onTap:
                                    () => controller.notificationOnTap(index),
                                titleAlignment:
                                    ListTileTitleAlignment.titleHeight,
                                title: MainText(text: item.title ?? ''),
                                subtitle: MainText(text: item.body ?? ''),
                                leading: Icon(
                                  Icons.circle,
                                  size: 16,
                                  color:
                                      item.isRead!
                                          ? AppColors.lightGrey
                                          : AppColors.primary,
                                ),
                              );
                            },
                          ),
                );
              }),
            ),
          ],
        ).paddingSymmetric(
          horizontal: fullWidth * 0.02,
          vertical: verticalPagePadding,
        ),
      ),
    );
  }
}



