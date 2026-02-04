import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/business_loan/controller/business_loan_controller.dart';
import 'package:jovera_finance/screens/business_loan/view/business_loan_information_view.dart';
import 'package:jovera_finance/screens/business_loan/widget/transaction_type_widget.dart';

import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/utilities/extensions/widget_extensions.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';

class BusinessLoanApplyAsView extends ConsumerWidget {
  const BusinessLoanApplyAsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(businessLoanControllerProvider.notifier);
    ref.watch(businessLoanControllerProvider);
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
                    controller.applicantType = "SME - Small, Medium Company";
                  },
                  title: "SME - Small, Medium Company",
                  controller: controller,
                ),
                SizedBox(height: fullHeight * 0.02),
                TransactionTypeWidget(
                  onTap: () {
                    controller.applicantType = "Cash";
                    controller.paymentMaxPeriod = 60;
                    controller.paymentPeriod = 20;
                    controller.interestRate = 8.5;
                  },
                  title: "Cash",
                  controller: controller,
                ),
                SizedBox(height: fullHeight * 0.02),
                TransactionTypeWidget(
                  onTap: () {
                    controller.applicantType = "Car Loan";
                  },
                  title: "Car Loan",
                  controller: controller,
                ),
                SizedBox(height: fullHeight * 0.02),
                TransactionTypeWidget(
                  onTap: () {
                    controller.applicantType = "Equipment Loan";
                    controller.paymentMaxPeriod = 60;
                    controller.paymentPeriod = 20;
                    controller.interestRate = 8.5;
                  },
                  title: "Equipment Loan",
                  controller: controller,
                ),
              ],
            ),
          ),

          CustomButton(
            onPressed: () {
              AppNavigator.push(const BusinessLoanInformationView());
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
