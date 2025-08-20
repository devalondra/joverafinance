import 'package:flutter/material.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';

class BackgroundDecoration extends StatelessWidget {
  const BackgroundDecoration({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: fullWidth * 0.03,
        vertical: fullHeight * 0.002,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(fullWidth * 0.02),
        color: AppColors.black2,
      ),
      child: child,
    );
  }
}
