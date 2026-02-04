import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/personal_loan/controller/personal_loan_controller.dart';
import 'package:jovera_finance/screens/personal_loan/view/personal_loan_information_view.dart';
import 'package:jovera_finance/screens/personal_loan/widget/transaction_type_widget.dart';

import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/utilities/extensions/widget_extensions.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';

class PersonalLoanApplyAsView extends ConsumerWidget {
  const PersonalLoanApplyAsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(personalLoanControllerProvider.notifier);
    ref.watch(personalLoanControllerProvider);
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
                    controller.applicantType = "Employee";
                  },
                  title: "Employee",
                  controller: controller,
                ),
                SizedBox(height: fullHeight * 0.02),
                TransactionTypeWidget(
                  onTap: () {
                    controller.applicantType = "Investor";
                    controller.paymentMaxPeriod = 60;
                    controller.paymentPeriod = 20;
                    controller.interestRate = 8.5;
                  },
                  title: "Investor",
                  controller: controller,
                ),
              ],
            ),
          ),

          CustomButton(
            onPressed: () {
              AppNavigator.push(PersonalLoanInformationView());
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
