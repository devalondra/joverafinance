import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/screens/main_drawer/view/edit_profile_view.dart';
import 'package:jovera_finance/screens/main_drawer/widget/profile_fields.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/background.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';

class MyProfileView extends GetView<BottomNavigationBarController> {
  const MyProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
      appLoadingController: controller.appLoadingController,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: fullHeight * 0.02),
                  CustomPageTitle(
                    back: true,
                    notification: false,
                    title: "Profile".tr,
                  ),
                  SizedBox(height: fullHeight * 0.03),
                  Obx(
                    () => Center(
                      child: CircleAvatar(
                        backgroundColor: AppColors.backgroundColor,
                        radius: fullWidth * 0.2,

                        child:
                            controller.profilePicturePath.value == ''
                                ? SvgPicture.asset(
                                  "assets/icons/profile_icon.svg",
                                  fit: BoxFit.fill,
                                )
                                : null,
                        backgroundImage:
                            controller.profilePicturePath.value != ''
                                ? controller.profilePicturePath.value
                                        .startsWith('https')
                                    ? NetworkImage(
                                      controller.profilePicturePath.value,
                                    )
                                    : FileImage(
                                      File(controller.profilePicturePath.value),
                                    )
                                : null,
                      ),
                    ),
                  ),

                  SizedBox(height: fullHeight * 0.04),
                  Profilefields(controller: controller),
                ],
              ),
            ),
            CustomButton(
              onPressed: () {
                Get.to(() => EditProfileView());
              },
              text: "Edit".tr,
            ).paddingOnly(bottom: fullHeight * 0.08),
          ],
        ).paddingSymmetric(
          horizontal: horizontalPagePadding,
          vertical: verticalPagePadding,
        ),
      ),
    );
  }
}
