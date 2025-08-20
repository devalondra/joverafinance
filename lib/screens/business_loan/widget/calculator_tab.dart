import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/business_loan/controller/business_loan_controller.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class CalculatorTab extends StatelessWidget {
  const CalculatorTab({
    super.key,
    required this.controller,
    required this.title,
  });
  final String title;
  final BusinessLoanController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: () {
          controller.calculatorType.value = title;
          if (title == "UAE National") {
            controller.paymentMaxPeriod.value = 60;
          } else {
            controller.paymentMaxPeriod.value = 48;
            controller.paymentPeriod.value = 15;
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: fullWidth * 0.03,
            vertical: fullHeight * 0.002,
          ),
          decoration: BoxDecoration(
            color:
                controller.calculatorType.value == title
                    ? AppColors.primary
                    : AppColors.black2,
            borderRadius: BorderRadius.circular(fullWidth * 0.01),
          ),
          child: MainText(text: title),
        ),
      ),
    );
  }
}
