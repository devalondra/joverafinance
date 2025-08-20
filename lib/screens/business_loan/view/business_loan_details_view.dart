import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/business_loan/controller/business_loan_controller.dart';
import 'package:jovera_finance/screens/business_loan/view/business_loan_documents_view.dart';

import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_validators.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';
import 'package:jovera_finance/widgets/custom_text_field.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class BusinessLoanDetailsView extends GetView<BusinessLoanController> {
  const BusinessLoanDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                CustomPageTitle(
                  back: true,
                  notification: false,
                  title: "Personal Details",
                ),
                SizedBox(height: fullHeight * 0.05),
                CustomTextField(
                  controller: controller.personalNameController.value,
                  hintText: "Full Name",
                  validator: (value) {
                    return AppValidators().textValidation(value);
                  },
                ).paddingOnly(bottom: fullHeight * 0.03),
                DropdownButtonFormField(
                  dropdownColor: AppColors.black2,
                  isExpanded: true,
                  iconEnabledColor: AppColors.grey,
                  decoration: InputDecoration(
                    fillColor: AppColors.black2,
                    alignLabelWithHint: true,
                    //  labelText: labelText,
                    labelStyle: TextStyle(color: AppColors.grey, fontSize: 14),
                    isDense: true,
                    labelText:
                        controller.nationalityType.value.isEmpty
                            ? ""
                            : "Nationality",
                    contentPadding: EdgeInsets.only(bottom: fullHeight * 0.01),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.grey, width: 1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.grey, width: 1),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  value:
                      controller.nationalityType.value.isEmpty
                          ? null
                          : controller.nationalityType.value,

                  hint: MainText(text: "Choose", color: AppColors.lightGrey),
                  items:
                      controller.nationalities
                          .map(
                            (nationality) => DropdownMenuItem(
                              value: nationality,
                              child: MainText(
                                text: nationality,
                                color: AppColors.grey,
                              ),
                            ),
                          )
                          .toList(),

                  onChanged: (v) {
                    controller.nationalityType.value = v.toString();
                  },
                ).paddingOnly(bottom: fullHeight * 0.01),
                CustomTextField(
                  alignLabelWithHint: true,
                  controller: controller.personalPhoneNumberController.value,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
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
              Get.to(() => BusinessLoanDocumentsView());
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
