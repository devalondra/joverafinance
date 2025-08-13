import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/mortgage/binding/mortgage_binding.dart';
import 'package:jovera_finance/screens/mortgage/controller/mortgage_controller.dart';
import 'package:jovera_finance/screens/mortgage/mortgage_apply/view/company/mortgage_company_details_view.dart';
import 'package:jovera_finance/screens/mortgage/mortgage_apply/view/individual/mortgage_personal_details_view.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';

class ApplyAsView extends GetView<MortgageController> {
  const ApplyAsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          SizedBox(height: verticalPagePadding * 2),
          CustomPageTitle(back: true, notification: false, title: "Mortgage"),
          SizedBox(height: fullHeight * 0.3),
          CustomButton(
            onPressed: () {
              controller.applicantType.value = "Individual";
              Get.to(() => MortgagePersonalDetailsView());
            },
            text: "Individual",
            height: fullHeight * 0.065,
          ),
          SizedBox(height: fullHeight * 0.02),
          CustomButton(
            borderColor: AppColors.white,
            color: AppColors.backgroundColor,
            onPressed: () {
              controller.applicantType.value = "Company";
              Get.to(
                () => MortgageCompanyDetailsView(),
                binding: MortgageBinding(),
              );
            },
            text: "Apply as a Company",
            height: fullHeight * 0.065,
          ),
        ],
      ).paddingSymmetric(
        horizontal: horizontalPagePadding,
        vertical: verticalPagePadding,
      ),
    );
  }
}
