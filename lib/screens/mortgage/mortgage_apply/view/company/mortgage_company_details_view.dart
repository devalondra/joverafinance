import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/mortgage/controller/mortgage_controller.dart';
import 'package:jovera_finance/screens/mortgage/mortgage_apply/view/company/mortgage_company_documents_view.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_validators.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';
import 'package:jovera_finance/widgets/custom_text_field.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class MortgageCompanyDetailsView extends GetView<MortgageController> {
  const MortgageCompanyDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          SizedBox(height: verticalPagePadding),
          Expanded(
            child: ListView(
              children: [
                CustomPageTitle(
                  back: true,
                  notification: false,
                  title: "Company Owner Details",
                ),
                SizedBox(height: fullHeight * 0.05),
                CustomTextField(
                  controller: controller.personalNameController.value,
                  hintText: "Full Name",
                  validator: (value) {
                    return AppValidators().textValidation(value);
                  },
                ).paddingOnly(bottom: fullHeight * 0.02),
                InkWell(
                  onTap: () {
                    showCountryPicker(
                      useSafeArea: false,
                      countryListTheme: CountryListThemeData(
                        backgroundColor: AppColors.black2,
                        textStyle: TextStyle(color: AppColors.lightText),
                      ),
                      context: context,
                      onSelect: (country) {
                        controller.personalNationalityController.value.text =
                            country.name;
                      },
                    );
                  },
                  child: CustomTextField(
                    controller: controller.personalNationalityController.value,
                    hintText: "Nationality",
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      return AppValidators().textValidation(value);
                    },
                    disable: true,
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.lightGrey,
                    ),
                  ).paddingOnly(bottom: fullHeight * 0.02),
                ),
                CustomTextField(
                  alignLabelWithHint: true,
                  controller: controller.personalPhoneNumberController.value,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  //   inputFormatters: phoneInputFormatters,
                  isDense: true,
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
                            controller.mobileCountryCode.value =
                                country.phoneCode;
                          },
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(
                            () => MainText(
                              text:
                                  controller.mobileCountryCode.value.startsWith(
                                        "+",
                                      )
                                      ? controller.mobileCountryCode.value
                                      : "+${controller.mobileCountryCode.value}",

                              fontSize: 12.spMin,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.lightText,
                          ),
                        ],
                      ),
                    ),
                  ).paddingSymmetric(vertical: fullHeight * 0.005),
                  hintText: "Phone Number",
                  validator: (value) {
                    return AppValidators().phoneValidation(value);
                  },
                ).paddingOnly(bottom: fullHeight * 0.02),
                CustomTextField(
                  controller: controller.personalEmailController.value,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Email",
                  validator: (value) {
                    return AppValidators().email(value);
                  },
                ).paddingOnly(bottom: fullHeight * 0.02),
              ],
            ),
          ),

          CustomButton(
            onPressed: () {
              Get.to(() => MortgageCompanyDocumentsView());
            },
            text: "Next",
          ),
          SizedBox(height: fullHeight * 0.05),
        ],
      ).paddingSymmetric(
        horizontal: horizontalPagePadding,
        vertical: verticalPagePadding,
      ),
    );
  }
}
