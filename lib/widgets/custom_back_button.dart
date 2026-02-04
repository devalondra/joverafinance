import 'package:flutter/material.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/utilities/extensions/widget_extensions.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppNavigator.pop();
      },
      child: Container(
        padding: EdgeInsets.all(fullWidth * 0.015),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: 16,
        ).paddingOnly(left: fullWidth * 0.01),
      ),
    ).paddingSymmetric(
      horizontal: fullWidth * 0.02,
      vertical: fullWidth * 0.01,
    );
  }
}
