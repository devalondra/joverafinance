import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/mortgage/common/mortgage_summary_view.dart';
import 'package:jovera_finance/screens/mortgage/controller/mortgage_controller.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_dropdown.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class PropertyDetailsView extends GetView<MortgageController> {
  const PropertyDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Obx(
            () => Expanded(
              child: ListView(
                children: [
                  CustomPageTitle(
                    back: true,
                    notification: false,
                    title: "Property Details",
                  ),
                  SizedBox(height: fullHeight * 0.05),
                  MainText(
                    text: "Property Type",
                  ).paddingOnly(bottom: fullHeight * 0.02),
                  CustomDropdown(
                    backgroundDecoration: true,
                    labelText:
                        controller.propertyType.value.isEmpty
                            ? ""
                            : "Property Type",
                    value:
                        controller.propertyType.value.isEmpty
                            ? null
                            : controller.propertyType.value,

                    hint: MainText(text: "Villa", color: AppColors.lightGrey),
                    items:
                        controller.properties
                            .map(
                              (property) => DropdownMenuItem(
                                value: property,
                                child: MainText(
                                  text: property,
                                  color: AppColors.grey,
                                ),
                              ),
                            )
                            .toList(),

                    onChanged: (v) {
                      controller.propertyType.value = v;
                    },
                  ).paddingOnly(bottom: fullHeight * 0.025),
                  MainText(
                    text: "Property Location",
                  ).paddingOnly(bottom: fullHeight * 0.02),
                  CustomDropdown(
                    backgroundDecoration: true,
                    labelText:
                        controller.propertyLocation.value.isEmpty
                            ? ""
                            : "Property Location",
                    value:
                        controller.propertyLocation.value.isEmpty
                            ? null
                            : controller.propertyLocation.value,

                    hint: MainText(
                      text: "Abu Dhabi",
                      color: AppColors.lightGrey,
                    ),
                    items:
                        controller.emirates
                            .map(
                              (emirate) => DropdownMenuItem(
                                value: emirate,
                                child: MainText(
                                  text: emirate,
                                  color: AppColors.grey,
                                ),
                              ),
                            )
                            .toList(),
                    onChanged: (v) {
                      controller.propertyLocation.value = v;
                    },
                  ).paddingOnly(bottom: fullHeight * 0.025),
                  MainText(
                    text: "Property Condition",
                  ).paddingOnly(bottom: fullHeight * 0.02),
                  CustomDropdown(
                    backgroundDecoration: true,
                    labelText:
                        controller.propertyCondition.value.isEmpty
                            ? ""
                            : "Property Condition",
                    value:
                        controller.propertyCondition.value.isEmpty
                            ? null
                            : controller.propertyCondition.value,

                    hint: MainText(text: "New", color: AppColors.lightGrey),
                    items:
                        controller.conditions
                            .map(
                              (condition) => DropdownMenuItem(
                                value: condition,
                                child: MainText(
                                  text: condition,
                                  color: AppColors.grey,
                                ),
                              ),
                            )
                            .toList(),
                    onChanged: (v) {
                      controller.propertyCondition.value = v;
                    },
                  ).paddingOnly(bottom: fullHeight * 0.025),
                ],
              ),
            ),
          ),
          CustomButton(
            onPressed: () {
              Get.to(() => MortgageSummaryView());
            },
            text: "Next",
          ).paddingOnly(bottom: fullHeight * 0.025),
        ],
      ).paddingSymmetric(
        horizontal: horizontalPagePadding,
        vertical: verticalPagePadding,
      ),
    );
  }
}
