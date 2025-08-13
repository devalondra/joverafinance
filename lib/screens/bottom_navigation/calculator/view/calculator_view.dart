import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/calculator/controller/calculator_controller.dart';
import 'package:jovera_finance/screens/mortgage/mortgage_apply/view/mortgage_information_view.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';

class CalculatorView extends GetView<CalculatorController> {
  const CalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CustomPageTitle(
          back: false,
          notification: false,
          title: "Mortgage Calculator",
        ),
        CustomButton(
          onPressed: () {
            Get.to(() => MortgageInformationView());
          },
          text: "Apply",
        ),
      ],
    ).paddingSymmetric(
      horizontal: horizontalPagePadding,
      vertical: verticalPagePadding,
    );
  }
}
