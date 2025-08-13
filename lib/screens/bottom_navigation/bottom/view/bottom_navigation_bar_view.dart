import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/controller/chat_controller.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class BottomnavigationBarView extends GetView<BottomNavigationBarController> {
  const BottomnavigationBarView({super.key});

  /// GetX-friendly exit dialog
  Future<bool> _showExitDialog() async {
    return await Get.dialog<bool>(
          AlertDialog(
            backgroundColor: AppColors.black2,
            title: MainText(text: "Exit App", color: AppColors.primary),
            content: MainText(text: "Are you sure you want to exit the app?"),
            actions: [
              TextButton(
                onPressed: () => Get.back(result: false),
                child: MainText(text: "Cancel"),
              ),
              TextButton(
                onPressed: () => Get.back(result: true),
                child: MainText(text: "Exit", color: AppColors.primary),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (controller.selectedIndex.value != 0) {
          controller.selectedIndex.value = 0;
        } else {
          if (didPop) return;

          bool confirmExit = await _showExitDialog();
          if (confirmExit) {
            SystemNavigator.pop();
          }
        }
      },
      child: Obx(
        () => Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.backgroundColor,

          body: Center(
            child: controller.widgetOptions.elementAt(
              controller.selectedIndex.value,
            ),
          ),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            backgroundColor: AppColors.black2,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            useLegacyColorScheme: true,
            unselectedItemColor: AppColors.textGrey,
            selectedItemColor: AppColors.primary,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icons/home_icon.svg",
                  colorFilter: ColorFilter.mode(
                    controller.selectedIndex.value == 0
                        ? AppColors.primary
                        : AppColors.textGrey,
                    BlendMode.srcIn,
                  ),
                ),
                label: "Home".tr,
                backgroundColor: AppColors.black2,
              ),
              BottomNavigationBarItem(
                backgroundColor: AppColors.black2,
                icon: SvgPicture.asset(
                  "assets/icons/loan_icon.svg",
                  colorFilter: ColorFilter.mode(
                    controller.selectedIndex.value == 1
                        ? AppColors.primary
                        : AppColors.textGrey,
                    BlendMode.srcIn,
                  ),
                ),
                label: "Services".tr,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icons/calculator_icon.svg",
                  colorFilter: ColorFilter.mode(
                    controller.selectedIndex.value == 2
                        ? AppColors.primary
                        : AppColors.textGrey,
                    BlendMode.srcIn,
                  ),
                ),
                label: "Calculator".tr,
                backgroundColor: AppColors.black2,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icons/chat_icon.svg",
                  colorFilter: ColorFilter.mode(
                    controller.selectedIndex.value == 3
                        ? AppColors.primary
                        : AppColors.textGrey,
                    BlendMode.srcIn,
                  ),
                ),
                label: "Chat".tr,
                backgroundColor: AppColors.black2,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icons/user_profile_icon.svg",
                  colorFilter: ColorFilter.mode(
                    controller.selectedIndex.value == 4
                        ? AppColors.primary
                        : AppColors.textGrey,
                    BlendMode.srcIn,
                  ),
                ),
                label: "Profile".tr,

                backgroundColor: AppColors.black2,
              ),
            ],
            onTap: (index) {
              controller.onItemTapped(index);

              if (index == 3) {
                Future.delayed(const Duration(milliseconds: 300), () {
                  if (Get.isRegistered<ChatController>()) {
                    Get.find<ChatController>().scrollToBottom();
                  }
                });
              }
            },
          ),

          endDrawer: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            child: Drawer(
              backgroundColor: AppColors.black2,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Drawer Header
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: AppColors.primary,
                      width: double.infinity,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(
                              "assets/icons/user_profile_icon.svg",
                              width: 28,
                              colorFilter: ColorFilter.mode(
                                AppColors.primary,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MainText(text: "John Doe", color: Colors.white),
                              MainText(
                                text: "john@example.com",
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    ListTile(
                      leading: SvgPicture.asset(
                        "assets/icons/user_profile_icon.svg",
                        width: 24,
                        colorFilter: ColorFilter.mode(
                          AppColors.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      title: MainText(text: "Profile", color: Colors.white),
                      onTap: () {},
                    ),

                    ListTile(
                      leading: Icon(Icons.lock, color: AppColors.primary),
                      title: MainText(
                        text: "Change Password",
                        color: Colors.white,
                      ),
                      onTap: () {},
                    ),

                    ListTile(
                      leading: Icon(Icons.settings, color: AppColors.primary),
                      title: MainText(text: "Settings", color: Colors.white),
                      onTap: () {},
                    ),

                    Divider(color: Colors.grey.shade700),

                    ListTile(
                      leading: Icon(Icons.logout, color: Colors.red),
                      title: MainText(text: "Logout", color: Colors.red),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
