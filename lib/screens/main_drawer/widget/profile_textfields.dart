import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_validators.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/custom_text_field.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class FillProfileTextFields extends StatelessWidget {
  const FillProfileTextFields({super.key, required this.controller});
  final BottomNavigationBarController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: controller.nameController.value,
          hintText: "Name".tr,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          validator: (value) {
            return AppValidators().textValidation(value);
          },
          border: true,
          textColor: AppColors.white,
          borderColor: AppColors.white,
          hintStyle: TextStyle(color: AppColors.lightGrey),
        ).paddingOnly(bottom: fullHeight * 0.025),
        CustomTextField(
          controller: controller.emailController.value,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          hintText: "Email".tr,
          validator: (value) {
            return AppValidators().email(value);
          },
          border: true,
          textColor: AppColors.white,
          borderColor: AppColors.white,
          hintStyle: TextStyle(color: AppColors.lightGrey),
        ).paddingOnly(bottom: fullHeight * 0.025),
        // Obx(() {
        //   int? maxLength = phoneLengthMap[controller.countryCode.value];
        //   return CustomTextField(
        //     controller: controller.phoneNumberController.value,
        //     hintText: "Phone number".tr,
        //     keyboardType: TextInputType.phone,       textInputAction: TextInputAction.done,
        //     inputFormatters: [
        //       ...phoneInputFormatters,
        //       if (maxLength != null)
        //         LengthLimitingTextInputFormatter(maxLength),
        //     ],
        //     readOnly: controller.countryCode.value.isEmpty,
        //     prefix: SizedBox(
        //       child: InkWell(
        //         onTap: () {
        //           showCountryPicker(
        //             useSafeArea: true,
        //             showPhoneCode: true,
        //             countryListTheme: CountryListThemeData(
        //               backgroundColor: AppColors.black2,
        //               textStyle: TextStyle(color: AppColors.lightText),
        //             ),
        //             context: context,
        //             onSelect: (country) {
        //               controller.phoneNumberController.value.clear();
        //               controller.countryCode.value = country.phoneCode;
        //             },
        //           );
        //         },
        //         child: Row(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             MainText(
        //               text:
        //                   controller.countryCode.value.startsWith("+")
        //                       ? controller.countryCode.value
        //                       : "+${controller.countryCode.value}",
        //               fontSize: 12.spMin,
        //             ),
        //             Icon(Icons.arrow_drop_down, color: AppColors.lightText),
        //           ],
        //         ),
        //       ),
        //     ).paddingSymmetric(
        //       // vertical: fullHeight * 0.02,
        //       horizontal: fullWidth * 0.02,
        //     ),

        //     validator: (value) {
        //       if (controller.countryCode.value.isEmpty) {
        //         return "Please select country code first";
        //       }
        //       if (maxLength != null && (value?.length ?? 0) != maxLength) {
        //         return "Number must be $maxLength digits";
        //       }
        //       return AppValidators().textValidation(value);
        //     },

        //     border: true,
        //     textColor: AppColors.white,
        //     borderColor: AppColors.white,
        //     hintStyle: TextStyle(color: AppColors.lightGrey),
        //   ).paddingOnly(bottom: fullHeight * 0.025);
        // }),
        Obx(() {
          int? maxLength = phoneLengthMap[controller.whatsappCountryCode.value];
          return CustomTextField(
            controller: controller.profileWhatsappController.value,
            hintText: "WhatsApp number".tr,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              ...phoneInputFormatters,
              if (maxLength != null)
                LengthLimitingTextInputFormatter(maxLength),
            ],
            readOnly: controller.whatsappCountryCode.value.isEmpty,
            prefix: SizedBox(
              child: InkWell(
                onTap: () {
                  showCountryPicker(
                    useSafeArea: true,
                    showPhoneCode: true,
                    countryListTheme: CountryListThemeData(
                      backgroundColor: AppColors.black2,
                      textStyle: TextStyle(color: AppColors.lightText),
                    ),
                    context: context,
                    onSelect: (country) {
                      controller.profileWhatsappController.value.clear();
                      controller.whatsappCountryCode.value = country.phoneCode;
                    },
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MainText(
                      text:
                          controller.whatsappCountryCode.value.startsWith("+")
                              ? controller.whatsappCountryCode.value
                              : "+${controller.whatsappCountryCode.value}",
                      fontSize: 12.spMin,
                    ),
                    Icon(Icons.arrow_drop_down, color: AppColors.lightText),
                  ],
                ),
              ),
            ).paddingSymmetric(horizontal: fullWidth * 0.02),

            validator: (value) {
              if (controller.whatsappCountryCode.value.isEmpty) {
                return "Please select country code first";
              }
              if (maxLength != null && (value?.length ?? 0) != maxLength) {
                return "Number must be $maxLength digits";
              }
              return AppValidators().textValidation(value);
            },

            border: true,
            textColor: AppColors.white,
            borderColor: AppColors.white,
            hintStyle: TextStyle(color: AppColors.lightGrey),
          ).paddingOnly(bottom: fullHeight * 0.025);
        }),
      ],
    );
  }
}
