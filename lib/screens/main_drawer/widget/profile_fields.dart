import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/custom_text_field.dart';

class Profilefields extends StatelessWidget {
  const Profilefields({super.key, required this.controller});
  final BottomNavigationBarController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: controller.nameController.value,
          hintText: "Name".tr,
          disable: true,

          border: true,
          textColor: AppColors.white,
          borderColor: AppColors.white,
          hintStyle: TextStyle(color: AppColors.lightGrey),
        ).paddingOnly(bottom: fullHeight * 0.025),
        CustomTextField(
          controller: controller.emailController.value,
          hintText: "Email".tr,
          disable: true,

          border: true,
          textColor: AppColors.white,
          borderColor: AppColors.white,
          hintStyle: TextStyle(color: AppColors.lightGrey),
        ).paddingOnly(bottom: fullHeight * 0.025),
        CustomTextField(
          controller: controller.phoneNumberController.value,
          hintText: "Phone number".tr,
          disable: true,

          border: true,
          textColor: AppColors.white,
          borderColor: AppColors.white,
          hintStyle: TextStyle(color: AppColors.lightGrey),
        ).paddingOnly(bottom: fullHeight * 0.025),
        CustomTextField(
          controller: controller.profileWhatsappController.value,
          hintText: "Whatsapp number".tr,
          disable: true,

          border: true,
          textColor: AppColors.white,
          borderColor: AppColors.white,
          hintStyle: TextStyle(color: AppColors.lightGrey),
        ).paddingOnly(bottom: fullHeight * 0.025),
      ],
    );
  }
}
