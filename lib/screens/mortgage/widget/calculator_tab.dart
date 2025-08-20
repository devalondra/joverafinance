import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/mortgage/controller/mortgage_controller.dart';
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
  final MortgageController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: () {
          controller.calculatorType.value = title;
          if (title == "UAE National") {
            controller.advancePercentage.value = 0.2;
            controller.advance.value = "20%";
          } else {
            controller.advancePercentage.value = 0.25;
            controller.advance.value = "25%";
          }
          controller.advancePayment.value =
              controller.advancePercentage.value *
              controller.propertyPrice.value;
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
