import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/mortgage/controller/mortgage_controller.dart';
import 'package:jovera_finance/screens/mortgage/common/apply_as_view.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/instructions_widget.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class MortgageInformationView extends GetView<MortgageController> {
  const MortgageInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        children: [
          SizedBox(height: verticalPagePadding),
          MainText(text: "Welcome.", fontSize: 22, fontWeight: FontWeight.w600),
          MainText(
            text: "Apply in just minutes.",
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: verticalPagePadding),
          InstructionsWidget(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: instructionsList.length,
              itemBuilder: (context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.circle,
                      size: fullWidth * 0.03,
                      color: AppColors.grey,
                    ).paddingOnly(top: fullHeight * 0.005),
                    SizedBox(width: fullWidth * 0.04),
                    Expanded(child: MainText(text: instructionsList[index])),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: verticalPagePadding * 2),
          CustomButton(
            onPressed: () {
              print("hjhgjhj");
              Get.lazyPut<MortgageController>(() => MortgageController());
              Get.to(() => ApplyAsView());
            },
            text: "Apply",
          ),
        ],
      ).paddingSymmetric(
        horizontal: horizontalPagePadding,
        vertical: verticalPagePadding,
      ),
    );
  }

  static const List instructionsList = [
    "All Documents must be in PDF or clear image format.",
    "Make sure all documents are valid and not expired.",
    "Additional documents may be requested if needed.",
  ];
}
