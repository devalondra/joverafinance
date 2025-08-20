import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_validators.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/screens/auth/signup/controller/signup_controller.dart';
import 'package:jovera_finance/widgets/custom_text_field.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class SignupTextFields extends StatelessWidget {
  const SignupTextFields({super.key, required this.controller});
  final SignUpController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: controller.nameController.value,
          hintText: "Name".tr,
          textInputAction: TextInputAction.next, // Moves focus to next.
          onSubmitted: (_) => FocusScope.of(context).nextFocus(),
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
          hintText: "Email".tr,
          focusNode: FocusNode(),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next, 
          
          onSubmitted:
              (_) => FocusScope.of(context).requestFocus(controller.phoneFocus),
          validator: (value) {
            return AppValidators().email(value);
          },
          border: true,
          textColor: AppColors.white,
          borderColor: AppColors.white,
          hintStyle: TextStyle(color: AppColors.lightGrey),
        ).paddingOnly(bottom: fullHeight * 0.025),

        Obx(
          () => CustomTextField(
            controller: controller.phoneController.value,
            hintText: "Phone Number".tr,
            keyboardType: TextInputType.phone,
            focusNode: controller.phoneFocus,
            textInputAction: TextInputAction.next, // Moves focus to next.
            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
            validator: (value) {
              return AppValidators().textValidation(value);
            },
            // prefixIconConstraints: true,
            prefixIcon: SizedBox(
              //  width: fullWidth * 0.04,
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
                      controller.countryCode.value = country.phoneCode;
                    },
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MainText(
                      text:
                          controller.countryCode.value.startsWith("+")
                              ? controller.countryCode.value
                              : "+${controller.countryCode.value}",

                      fontSize: 12.spMin,
                    ),
                    Icon(Icons.arrow_drop_down, color: AppColors.lightText),
                  ],
                ),
              ),
            ).paddingSymmetric(
              vertical: fullHeight * 0.02,
              horizontal: fullWidth * 0.02,
            ),

            border: true,
            textColor: AppColors.white,
            borderColor: AppColors.white,
            hintStyle: TextStyle(color: AppColors.lightGrey),
          ).paddingOnly(bottom: fullHeight * 0.025),
        ),
        Obx(
          () => CustomTextField(
            controller: controller.whatsappController.value,
            hintText: "Whatsapp Number".tr,
            keyboardType: TextInputType.phone,
        
            textInputAction: TextInputAction.done, // Moves focus to next.
            onSubmitted: (_) => FocusScope.of(context).unfocus(),
            validator: (value) {
              return AppValidators().textValidation(value);
            },
            // prefixIconConstraints: true,
            prefixIcon: SizedBox(
              //  width: fullWidth * 0.04,
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
                      controller.whatsappCode.value = country.phoneCode;
                    },
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MainText(
                      text:
                          controller.whatsappCode.value.startsWith("+")
                              ? controller.whatsappCode.value
                              : "+${controller.whatsappCode.value}",

                      fontSize: 12.spMin,
                    ),
                    Icon(Icons.arrow_drop_down, color: AppColors.lightText),
                  ],
                ),
              ),
            ).paddingSymmetric(
              vertical: fullHeight * 0.02,
              horizontal: fullWidth * 0.02,
            ),

            border: true,
            textColor: AppColors.white,
            borderColor: AppColors.white,
            hintStyle: TextStyle(color: AppColors.lightGrey),
          ).paddingOnly(bottom: fullHeight * 0.025),
        ),

  ],
    );
  }
}
