import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/screens/auth/signup/controller/signup_controller.dart';
import 'package:jovera_finance/screens/auth/signup/widget/fill_profile_textfields.dart';
import 'package:jovera_finance/widgets/background.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class FillProfileView extends GetView<SignUpController> {
  const FillProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Background(
      appLoadingController: controller.appLoadingController,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: fullHeight * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.grey,
                          ),
                        ),

                        MainText(text: "Signup".tr),
                        SizedBox(width: fullWidth * 0.05),
                      ],
                    ),
                    SizedBox(height: fullHeight * 0.01),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     IconButton(
                    //       onPressed: () {
                    //         Get.back();
                    //       },
                    //       icon: Icon(
                    //         Icons.arrow_back_ios,
                    //         color: AppColors.grey,
                    //       ),
                    //     ),

                    //     MainText(text: "Fill Your Profile".tr),
                    //     SizedBox(width: fullWidth * 0.02),
                    //   ],
                    // ),
                    SizedBox(height: fullHeight * 0.02),
                    SizedBox(
                      width: fullWidth * 0.7,
                      child: Center(
                        child: Stack(
                          children: [
                            Obx(
                              () => CircleAvatar(
                                backgroundColor: AppColors.backgroundColor,

                                radius: fullWidth * 0.25,

                                backgroundImage:
                                    controller.profilePicturePath.value != ''
                                        ? FileImage(
                                          File(
                                            controller.profilePicturePath.value,
                                          ),
                                        )
                                        : AssetImage(
                                          "assets/images/person.jpg",
                                        ),
                              ),
                            ),

                            Positioned(
                              bottom: fullHeight * 0.016,
                              right: fullWidth * 0.01,
                              child: InkWell(
                                onTap:
                                    () => controller.selectProfilePicture(
                                      context,
                                    ),
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
                      ),
                    ),

                    SizedBox(height: fullHeight * 0.04),
                    Form(
                      key: formKey,
                      child: FillProfileTextFields(controller: controller),
                    ),
                    SizedBox(height: fullHeight * 0.04),
                  ],
                ),
              ),
              CustomButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (controller.passwordController.value.text ==
                        controller.retypePasswordController.value.text) {
                      controller.signup();
                    } else {
                      appTools.showErrorSnackBar("Passwords do not match.");
                    }
               
                  } else {}
                },
                text: "Create Account".tr,
              ).paddingOnly(bottom: fullHeight * 0.01),
            ],
          ).paddingSymmetric(
            horizontal: horizontalPagePadding,
            vertical: verticalPagePadding,
          ),
        ),
      ),
    );
  }
}
