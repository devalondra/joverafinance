import 'package:flutter/material.dart';
import 'package:jovera_finance/screens/personal_loan/controller/personal_loan_controller.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class CalculatorSlider extends StatelessWidget {
  const CalculatorSlider({
    super.key,
    required this.controller,
    required this.max,
    required this.min,
    required this.onChanged,
    required this.value,
    required this.isDouble,
  });
  final PersonalLoanController controller;
  final double value;
  final double min;
  final double max;
  final bool isDouble;
  final Function(double v) onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          min: min,
          max: max,
          activeColor: AppColors.primary,
          value: value,
          onChanged: (v) => onChanged(v),
        ),
        isDouble
            ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainText(text: min.toStringAsFixed(1), fontSize: 12),
                MainText(text: max.toStringAsFixed(1), fontSize: 12),
              ],
            )
            : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainText(text: "${min.round()}", fontSize: 12),
                MainText(text: "${max.round()}", fontSize: 12),
              ],
            ),
      ],
    );
  }
}
