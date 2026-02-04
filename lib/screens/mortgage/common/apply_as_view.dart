import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/mortgage/controller/mortgage_controller.dart';
import 'package:jovera_finance/screens/mortgage/company/mortgage_company_details_view.dart';
import 'package:jovera_finance/screens/mortgage/personal/mortgage_personal_details_view.dart';
import 'package:jovera_finance/screens/mortgage/widget/transaction_type_widget.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/utilities/extensions/widget_extensions.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';

class ApplyAsView extends ConsumerWidget {
  const ApplyAsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(mortgageControllerProvider.notifier);
    ref.watch(mortgageControllerProvider);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          SizedBox(height: verticalPagePadding * 2),
          CustomPageTitle(
            back: true,
            notification: false,
            title: "Transactions based on",
          ),

          Expanded(
            child: ListView(
              children: [
                TransactionTypeWidget(
                  onTap: () {
                    controller.applicantType = "Salary";
                  },
                  title: "Salary",
                  controller: controller,
                ),
                SizedBox(height: fullHeight * 0.02),
                TransactionTypeWidget(
                  onTap: () {
                    controller.applicantType = "Self Employed";
                  },
                  title: "Self Employed",
                  controller: controller,
                ),
              ],
            ),
          ),

          CustomButton(
            onPressed: () {
              controller.applicantType == "Salary"
                  ? AppNavigator.push( MortgagePersonalDetailsView())
                  : AppNavigator.push(const MortgageCompanyDetailsView());
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
