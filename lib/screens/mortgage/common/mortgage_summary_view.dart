import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/mortgage/controller/mortgage_controller.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/background.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';
import 'package:jovera_finance/widgets/main_text.dart';
import 'package:jovera_finance/widgets/summary_widget.dart';

class MortgageSummaryView extends GetView<MortgageController> {
  const MortgageSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
      appLoadingController: controller.appLoadingController,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  CustomPageTitle(
                    back: true,
                    notification: false,
                    title: "Summary",
                  ),
                  SizedBox(height: fullHeight * 0.05),
                  Obx(
                    () => SummaryWidget(
                      title: "Mortgage Loan".tr,
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  MainText(
                                    text: "Loan Amount",
                                    fontSize: smallFont,
                                  ),
                                  MainText(
                                    text: ": ${controller.propertyPrice.value}",
                                    fontSize: smallFont,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  MainText(
                                    fontSize: smallFont,
                                    text: "Payment Period",
                                  ),
                                  MainText(
                                    fontSize: smallFont,
                                    text:
                                        " : ${controller.propertyPeriod.value} ",
                                  ),
                                  MainText(fontSize: smallFont, text: "Years"),
                                ],
                              ),
                              SizedBox(height: fullHeight * 0.02),
                              MainText(
                                text: "Personal Information",

                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: fullHeight * 0.01),
                              Row(
                                children: [
                                  MainText(text: "Name", fontSize: smallFont),
                                  MainText(
                                    text:
                                        " : ${controller.personalNameController.value.text}",
                                    fontSize: smallFont,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  MainText(
                                    text: "Nationality",
                                    fontSize: smallFont,
                                  ),
                                  MainText(
                                    text:
                                        " : ${controller.nationalityType.value.tr}",
                                    fontSize: smallFont,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  MainText(text: "Phone", fontSize: smallFont),
                                  MainText(
                                    text:
                                        " : ${controller.mobileCountryCode.value.startsWith("+") ? "" : "+"}${controller.mobileCountryCode.value}${controller.personalPhoneNumberController.value.text}",
                                    fontSize: smallFont,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  MainText(text: "Email", fontSize: smallFont),
                                  MainText(
                                    text:
                                        " : ${controller.personalEmailController.value.text}",
                                    fontSize: smallFont,
                                  ),
                                ],
                              ),
                              SizedBox(height: fullHeight * 0.02),
                              MainText(
                                text: "Property Information",

                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: fullHeight * 0.01),
                              Row(
                                children: [
                                  MainText(
                                    text: "Property Type",
                                    fontSize: smallFont,
                                  ),
                                  MainText(
                                    text:
                                        " : ${controller.propertyType.value.tr}",
                                    fontSize: smallFont,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  MainText(
                                    text: "Property Location",
                                    fontSize: smallFont,
                                  ),
                                  MainText(
                                    text:
                                        " : ${controller.propertyLocation.value.tr}",
                                    fontSize: smallFont,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  MainText(
                                    text: "Property Condition",
                                    fontSize: smallFont,
                                  ),
                                  MainText(
                                    text:
                                        " : ${controller.propertyCondition.value.tr}",
                                    fontSize: smallFont,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomButton(
              onPressed: () {
                controller.applyMortgageLoan();
              },
              text: "Submit",
            ).paddingOnly(bottom: fullHeight * 0.05),
          ],
        ).paddingSymmetric(
          horizontal: horizontalPagePadding,
          vertical: verticalPagePadding,
        ),
      ),
    );
  }
}
