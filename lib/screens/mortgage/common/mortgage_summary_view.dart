import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/mortgage/controller/mortgage_controller.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/utilities/extensions/widget_extensions.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';
import 'package:jovera_finance/widgets/background.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';
import 'package:jovera_finance/widgets/main_text.dart';
import 'package:jovera_finance/widgets/summary_widget.dart';

class MortgageSummaryView extends ConsumerWidget {
  const MortgageSummaryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(mortgageControllerProvider.notifier);
    ref.watch(mortgageControllerProvider);
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
                  SummaryWidget(
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
                                  text: ": ${controller.propertyPrice}",
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
                                  text: " : ${controller.propertyPeriod} ",
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
                                      " : ${controller.personalNameController.text}",
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
                                  text: " : ${controller.nationalityType.tr}",
                                  fontSize: smallFont,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                MainText(text: "Phone", fontSize: smallFont),
                                MainText(
                                  text:
                                      " : ${controller.mobileCountryCode.startsWith("+") ? "" : "+"}${controller.mobileCountryCode}${controller.personalPhoneNumberController.text}",
                                  fontSize: smallFont,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                MainText(text: "Email", fontSize: smallFont),
                                MainText(
                                  text:
                                      " : ${controller.personalEmailController.text}",
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
                                  text: " : ${controller.propertyType.tr}",
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
                                      " : ${controller.propertyLocation.tr}",
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
                                      " : ${controller.propertyCondition.tr}",
                                  fontSize: smallFont,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
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
