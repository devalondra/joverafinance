import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/screens/main_drawer/widget/profile_textfields.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/background.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';

class EditProfileView extends GetView<BottomNavigationBarController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
      appLoadingController: controller.appLoadingController,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.backgroundColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: fullHeight * 0.04),
                    CustomPageTitle(
                      back: true,
                      notification: false,
                      title: "Edit Profile".tr,
                    ),
                    SizedBox(height: fullHeight * 0.02),
                    Stack(
                      children: [
                        Obx(
                          () => Center(
                            child: CircleAvatar(
                              backgroundColor: AppColors.backgroundColor,
                              radius: fullWidth * 0.21,
                              backgroundImage:
                                  controller.profilePicturePath.value != ''
                                      ? controller.profilePicturePath.value
                                              .startsWith('https')
                                          ? NetworkImage(
                                            controller.profilePicturePath.value,
                                          )
                                          : FileImage(
                                            File(
                                              controller
                                                  .profilePicturePath
                                                  .value,
                                            ),
                                          )
                                      : null,

                              child:
                                  controller.profilePicturePath.value == ''
                                      ? SvgPicture.asset(
                                        "assets/icons/profile_icon.svg",
                                        fit: BoxFit.fill,
                                      )
                                      : null,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: fullHeight * 0.016,
                          right: fullWidth * 0.23,
                          child: InkWell(
                            onTap:
                                () => controller.selectProfilePicture(context),
                            child: SvgPicture.asset(
                              "assets/icons/edit_icon.svg",
                              fit: BoxFit.fill,
                              width: fullWidth * 0.1,
                              height: fullWidth * 0.1,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: fullHeight * 0.04),
                    FillProfileTextFields(controller: controller),
                  ],
                ),
              ),
              CustomButton(
                onPressed: () {
                  controller.editProfile();
                },
                text: "Save",
              ).paddingOnly(bottom: fullHeight * 0.01),
            ],
          ).paddingSymmetric(horizontal: horizontalPagePadding),
        ),
      ),
    );
  }
}
