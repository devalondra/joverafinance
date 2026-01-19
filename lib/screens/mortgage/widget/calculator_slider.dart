import 'package:flutter/material.dart';
import 'package:jovera_finance/screens/mortgage/controller/mortgage_controller.dart';
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
    this.divisions,
  });
  final MortgageController controller;
  final double value;
  final double min;
  final double max;
  final Function(double v) onChanged;
  final int? divisions;
  @override
  Widget build(BuildContext context) {
    final double safeMin = min <= max ? min : max;
    final double safeMax = min <= max ? max : min;
    final double safeValue = value.clamp(safeMin, safeMax).toDouble();
    return Column(
      children: [
        Slider(
          min: safeMin,
          max: safeMax,
          activeColor: AppColors.primary,
          value: safeValue,
          divisions: divisions,
          onChanged: (v) => onChanged(v),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MainText(text: "${safeMin.round()}", fontSize: 12),
            MainText(text: "${safeMax.round()}", fontSize: 12),
          ],
        ),
      ],
    );
  }
}
