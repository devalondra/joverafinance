import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/business_loan/controller/business_loan_controller.dart';
import 'package:jovera_finance/screens/business_loan/view/business_loan_information_view.dart';
import 'package:jovera_finance/screens/business_loan/widget/transaction_type_widget.dart';

import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';

class BusinessLoanApplyAsView extends GetView<BusinessLoanController> {
  const BusinessLoanApplyAsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          SizedBox(height: verticalPagePadding * 2),
          CustomPageTitle(back: true, notification: false, title: "Services"),

          Expanded(
            child: ListView(
              children: [
                TransactionTypeWidget(
                  onTap: () {
                    controller.applicantType.value = "SME";
                  },
                  title: "SME",
                  controller: controller,
                ),
                SizedBox(height: fullHeight * 0.02),
                TransactionTypeWidget(
                  onTap: () {
                    controller.applicantType.value = "Cash";
                    controller.paymentMaxPeriod.value = 60;
                    controller.paymentPeriod.value = 20;
                    controller.interestRate.value = 8.5;
                  },
                  title: "Cash",
                  controller: controller,
                ),
                SizedBox(height: fullHeight * 0.02),
                TransactionTypeWidget(
                  onTap: () {
                    controller.applicantType.value = "Car Loan";
                  },
                  title: "Car Loan",
                  controller: controller,
                ),
                SizedBox(height: fullHeight * 0.02),
                TransactionTypeWidget(
                  onTap: () {
                    controller.applicantType.value = "Equipment Loan";
                    controller.paymentMaxPeriod.value = 60;
                    controller.paymentPeriod.value = 20;
                    controller.interestRate.value = 8.5;
                  },
                  title: "Equipment Loan",
                  controller: controller,
                ),
              ],
            ),
          ),

          CustomButton(
            onPressed: () {
              Get.to(() => BusinessLoanInformationView());
            },
            text: "Next",
          ),
          SizedBox(height: fullHeight * 0.04),
        ],
      ).paddingSymmetric(
        horizontal: horizontalPagePadding * 1.5,
        vertical: verticalPagePadding,
      ),
    );
  }
}
