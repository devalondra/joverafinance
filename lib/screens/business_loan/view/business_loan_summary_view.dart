import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/business_loan/controller/business_loan_controller.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/utilities/extensions/widget_extensions.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';
import 'package:jovera_finance/widgets/background.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';
import 'package:jovera_finance/widgets/main_text.dart';
import 'package:jovera_finance/widgets/summary_widget.dart';

class BusinessLoanSummaryView extends ConsumerWidget {
  const BusinessLoanSummaryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(businessLoanControllerProvider.notifier);
    ref.watch(businessLoanControllerProvider);
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
                    title: "Business Loan",
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MainText(
                              text: "${"Loan Amount".tr}: ${controller.loanAmount}",
                              fontSize: smallFont,
                            ),
                            MainText(
                              fontSize: smallFont,
                              text:
                                  "${"Payment Period".tr}: ${controller.paymentPeriod} ${"Months".tr}",
                            ),
                            SizedBox(height: fullHeight * 0.02),
                            MainText(
                              text: "Personal Information",
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: fullHeight * 0.01),
                            MainText(
                              text:
                                  "${"Name".tr}: ${controller.personalNameController.text}",
                              fontSize: smallFont,
                            ),
                            MainText(
                              text:
                                  "${"Nationality".tr}: ${controller.nationalityType.tr}",
                              fontSize: smallFont,
                            ),
                            MainText(
                              text:
                                  "${"Phone".tr}: ${controller.mobileCountryCode.startsWith("+") ? "" : "+"}${controller.mobileCountryCode}${controller.personalPhoneNumberController.text}",
                              fontSize: smallFont,
                            ),
                            MainText(
                              text:
                                  "${"Email".tr}: ${controller.personalEmailController.text}",
                              fontSize: smallFont,
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
                controller.applyBusinessLoan();
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
