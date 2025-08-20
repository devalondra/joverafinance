import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/personal_loan/controller/personal_loan_controller.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class TransactionTypeWidget extends StatelessWidget {
  const TransactionTypeWidget({
    super.key,

    required this.controller,
    required this.onTap,
    required this.title,
  });
  final PersonalLoanController controller;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: () => onTap(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainText(
                  text: title,
                  color:
                      title == controller.applicantType.value
                          ? AppColors.primary
                          : AppColors.grey,
                ),
                title == controller.applicantType.value
                    ? Icon(Icons.radio_button_checked, color: AppColors.primary)
                    : Icon(Icons.radio_button_off, color: AppColors.grey),
              ],
            ),
            SizedBox(height: fullHeight * 0.01),
            Divider(color: AppColors.grey),
            SizedBox(height: fullHeight * 0.01),
          ],
        ),
      ),
    );
  }
}
