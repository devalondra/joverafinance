import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/screens/main_drawer/notification/binding/notification_binding.dart';
import 'package:jovera_finance/screens/main_drawer/notification/view/notification_view.dart';
import 'package:jovera_finance/screens/main_drawer/view/about_view.dart';
import 'package:jovera_finance/screens/main_drawer/view/contact_us_view.dart';
import 'package:jovera_finance/screens/main_drawer/view/my_profile_view.dart';
import 'package:jovera_finance/screens/main_drawer/view/settings_view.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/drawer_card.dart';
import 'package:jovera_finance/widgets/main_text.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBarController controller = Get.find();
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Row(
              children: [
                SizedBox(width: fullWidth * 0.01),
                Container(
                  height: fullWidth * 0.13,
                  width: fullWidth * 0.13,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.darkGrey),
                    image:
                        controller.authManager.appUser.value.picture != null &&
                                controller.authManager.appUser.value.picture !=
                                    ""
                            ? DecorationImage(
                              image: NetworkImage(
                                controller.authManager.appUser.value.picture!,
                              ),
                              fit: BoxFit.cover,
                            )
                            : DecorationImage(
                              image: AssetImage(
                                "assets/images/jovera_logo.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                  ),
                ),
                SizedBox(width: fullWidth * 0.03),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.authManager.isLogged.value
                        ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                MainText(text: 'Welcome Back'.tr),
                                SizedBox(width: fullWidth * 0.02),
                                Icon(
                                  Icons.waving_hand,
                                  color: AppColors.primary,
                                ),
                              ],
                            ),
                            MainText(
                              text:
                                  controller.authManager.appUser.value.name ==
                                          null
                                      ? ""
                                      : controller
                                          .authManager
                                          .appUser
                                          .value
                                          .name!,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        )
                        : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MainText(text: 'Easy Loans'.tr),
                            SizedBox(width: fullWidth * 0.02),
                            Icon(Icons.waving_hand, color: AppColors.primary),
                          ],
                        ),
                  ],
                ),
              ],
            ).paddingSymmetric(vertical: fullHeight * 0.01),
          ),

          const SizedBox(height: 8),

          SizedBox(height: fullHeight * 0.02),
          Obx(
            () =>
                controller.authManager.isLogged.value
                    ? Column(
                      children: [
                        DrawerCard(
                          title: "Profile",
                          controller: controller,
                          onTap: () {
                            Get.to(() => MyProfileView());
                          },
                          leadingIconPath: "assets/icons/edit_profile_icon.svg",
                        ).paddingSymmetric(horizontal: fullWidth * 0.02),
                        Divider(color: AppColors.darkGrey),
                      ],
                    )
                    : SizedBox(),
          ),
          Obx(
            () =>
                controller.authManager.isLogged.value
                    ? Column(
                      children: [
                        DrawerCard(
                          title: "Notifications",
                          controller: controller,
                          onTap: () {
                            Get.to(
                              () => NotificationView(),
                              binding: NotificationBinding(),
                            );
                          },
                          leadingIconPath: "assets/icons/edit_profile_icon.svg",
                        ).paddingSymmetric(horizontal: fullWidth * 0.02),
                        Divider(color: AppColors.darkGrey),
                      ],
                    )
                    : SizedBox(),
          ),
          DrawerCard(
            title: "Settings",
            controller: controller,
            onTap: () {
              Get.to(() => SettingsView(controller: controller));
            },
            leadingIconPath: "assets/icons/setting_icon.svg",
          ).paddingSymmetric(horizontal: fullWidth * 0.02),
          Divider(color: AppColors.darkGrey),
          DrawerCard(
            title: "Contact us",
            controller: controller,
            onTap: () {
              Get.to(() => ContactUsView());
            },
            leadingIconPath: "assets/icons/contact_icon.svg",
          ).paddingSymmetric(horizontal: fullWidth * 0.02),
          Divider(color: AppColors.darkGrey),
          DrawerCard(
            title: "About".tr,
            controller: controller,
            onTap: () {
              Get.to(() => AboutView());
            },
            leadingIconPath: "assets/icons/about_icon.svg",
          ).paddingSymmetric(horizontal: fullWidth * 0.02),
          Divider(color: AppColors.darkGrey),
          DrawerCard(
            title: "Privacy Policy".tr,
            controller: controller,
            onTap: () async {
              await launchUrl(
                Uri.parse("https://joveratourism.ae/components/privacyPolicy"),
              ).onError((error, stackTrace) {
                appTools.showErrorSnackBar(
                  'Something went wrong. Please check your connection.',
                );
                throw Exception();
              });
            },
            leadingIconPath: "assets/icons/privacy_icon.svg",
          ).paddingSymmetric(horizontal: fullWidth * 0.02),
          Divider(color: AppColors.darkGrey),
          DrawerCard(
            title: "Terms and Conditions".tr,
            controller: controller,
            onTap: () async {
              await launchUrl(
                Uri.parse(
                  "https://joveratourism.ae/components/termsConditions",
                ),
              ).onError((error, stackTrace) {
                appTools.showErrorSnackBar(
                  'Something went wrong. Please check your connection.',
                );
                throw Exception();
              });
            },
            leadingIconPath: "assets/icons/terms_and_conditions_icon.svg",
          ).paddingSymmetric(horizontal: fullWidth * 0.02),
          Divider(
            color: AppColors.darkGrey,
          ).paddingSymmetric(vertical: fullWidth * 0.02),
          controller.authManager.isLogged.value
              ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/logout_icon.svg",
                    colorFilter: ColorFilter.mode(
                      AppColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: fullWidth * 0.02),
                  InkWell(
                    onTap: () {
                      controller.authManager.logOut();
                    },
                    child: MainText(
                      text: "Logout".tr,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/logout_icon.svg",
                    colorFilter: ColorFilter.mode(
                      AppColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: fullWidth * 0.02),
                  InkWell(
                    onTap: () {
                      BottomNavigationBarController cont = Get.find();
                      cont.selectedIndex.value = 2;
                    },
                    child: MainText(
                      text: "Sign In".tr,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
        ],
      ),
    );
  }
}
