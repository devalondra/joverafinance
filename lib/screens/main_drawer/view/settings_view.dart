import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/screens/main_drawer/view/change_password_view.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/utilities/constants/app_tools.dart';
import 'package:jovera_finance/utilities/extensions/widget_extensions.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';
import 'package:jovera_finance/widgets/custom_text_field.dart';
import 'package:jovera_finance/widgets/drawer_card.dart';
import 'package:jovera_finance/widgets/main_text.dart';

import 'package:url_launcher/url_launcher.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  Future<bool> _showExitDialog(
    BuildContext context,
    BottomNavigationBarController controller,
  ) async {
    return await showDialog<bool>(
          context: context,
          builder:
              (_) => AlertDialog(
            backgroundColor: AppColors.black2,
            title: MainText(
              text: "Delete Account & Data",
              color: AppColors.primaryDark,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: fullHeight * 0.015),
                MainText(
                  text:
                      "Are you sure you want to delete your account and all related data permanently?",
                  fontSize: 14,
                ),
                SizedBox(height: fullHeight * 0.015),
                Row(
                  children: [
                    MainText(text: "Reason For Account Deletion", fontSize: 14),
                  ],
                ),
                SizedBox(height: fullHeight * 0.015),
                CustomTextField(
                  label: false,
                  controller: controller.deleteReasonController,

                  hintText: "Type".tr,
                  alignLabelWithHint: true,
                  border: true,
                  maxLines: 3,
                ),
                SizedBox(height: fullHeight * 0.015),
                InkWell(
                  onTap: () async {
                    Navigator.of(context).pop();
                    await launchUrl(
                      Uri.parse(
                        "https://joveratourism.ae/components/deleteAccount",
                      ),
                    ).onError((error, stackTrace) {
                      appTools.showErrorSnackBar(
                        'Something went wrong. Please check your connection.',
                      );
                      throw Exception();
                    });
                  },
                  child: Row(
                    children: [
                      MainText(
                        text: "Go To Account Deletion Policy",
                        color: AppColors.primary,
                        fontSize: 12.sp,
                      ),
                      SizedBox(width: fullWidth * 0.03),
                      Icon(
                        Icons.arrow_forward_sharp,
                        color: AppColors.primary,
                        size: fullWidth * 0.05,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: MainText(text: "Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                  controller.deleteAccount();
                },
                child: MainText(text: "Delete", color: AppColors.primaryDark),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(bottomNavigationBarControllerProvider.notifier);
    ref.watch(bottomNavigationBarControllerProvider);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      body: ListView(
        children: [
          SizedBox(height: fullHeight * 0.04),
          CustomPageTitle(
            back: true,
            notification: false,
            title: "Settings".tr,
          ).paddingSymmetric(horizontal: fullWidth * 0.05),
          SizedBox(height: fullHeight * 0.04),

          DrawerCard(
            title: controller.language ? "English".tr : "Arabic".tr,
            onTap: () {},
            controller: controller,
            language: true,
            leadingIconPath: "assets/icons/translate_icon.svg",
          ).paddingSymmetric(horizontal: fullWidth * 0.02),
          Divider(color: AppColors.darkGrey),
          ref.watch(authManagerProvider).isLogged
              ? Column(
                children: [
                  DrawerCard(
                    title: "Notifications".tr,
                    onTap: () {},
                    controller: controller,
                    notification: true,
                    leadingIconPath: "assets/icons/notification_icon.svg",
                  ),
                  Divider(color: AppColors.darkGrey),
                  DrawerCard(
                    title: "Reset Password".tr,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ChangePasswordView(),
                        ),
                      );
                    },
                    controller: controller,

                    leadingIconPath: "assets/icons/password_icon.svg",
                    notification: false,
                  ).paddingSymmetric(horizontal: fullWidth * 0.02),

                  Divider(color: AppColors.darkGrey),
                  DrawerCard(
                    title: "Delete Account".tr,
                    color: AppColors.primaryDark,
                    onTap: () {
                      _showExitDialog(context, controller);
                    },
                    controller: controller,

                    leadingIconPath: "assets/icons/delete_icon.svg",
                    notification: false,
                  ).paddingSymmetric(horizontal: fullWidth * 0.02),

                  Divider(color: AppColors.darkGrey),
                ],
              ).paddingSymmetric(horizontal: fullWidth * 0.02)
              : SizedBox(),
        ],
      ),
    );
  }
}
