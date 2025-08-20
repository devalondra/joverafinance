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
                      title: "Mortgage Loan",
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MainText(
                                text:
                                    "Loan Amount: ${controller.propertyPrice.value}",
                                fontSize: smallFont,
                              ),
                              MainText(
                                fontSize: smallFont,
                                text:
                                    "Payment Period: ${controller.propertyPeriod.value} Years",
                              ),
                              SizedBox(height: fullHeight * 0.02),
                              MainText(
                                text: "Personal Information",

                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: fullHeight * 0.01),
                              MainText(
                                text:
                                    "Name: ${controller.personalNameController.value.text}",
                                fontSize: smallFont,
                              ),
                              MainText(
                                text:
                                    "Nationality: ${controller.nationalityType.value}",
                                fontSize: smallFont,
                              ),
                              MainText(
                                text:
                                    "Phone: ${controller.mobileCountryCode.value.startsWith("+") ? "" : "+"}${controller.mobileCountryCode.value}${controller.personalPhoneNumberController.value.text}",
                                fontSize: smallFont,
                              ),
                              MainText(
                                text:
                                    "Email: ${controller.personalEmailController.value.text}",
                                fontSize: smallFont,
                              ),
                              SizedBox(height: fullHeight * 0.02),
                              MainText(
                                text: "Property Information",

                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: fullHeight * 0.01),
                              MainText(
                                text:
                                    "Property Type: ${controller.propertyType.value}",
                                fontSize: smallFont,
                              ),
                              MainText(
                                text:
                                    "Property Location: ${controller.propertyLocation.value}",
                                fontSize: smallFont,
                              ),
                              MainText(
                                text:
                                    "Property Condition: ${controller.propertyCondition.value}",
                                fontSize: smallFont,
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
