import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/mortgage/common/mortgage_summary_view.dart';
import 'package:jovera_finance/screens/mortgage/controller/mortgage_controller.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/utilities/extensions/widget_extensions.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_dropdown.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class PropertyDetailsView extends ConsumerWidget {
  const PropertyDetailsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(mortgageControllerProvider.notifier);
    ref.watch(mortgageControllerProvider);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Expanded(
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
                      controller.propertyType.isEmpty
                          ? ""
                          : "Property Type",
                  value:
                      controller.propertyType.isEmpty
                          ? null
                          : controller.propertyType,

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
                    controller.propertyType = v.toString();
                  },
                ).paddingOnly(bottom: fullHeight * 0.025),
                MainText(
                  text: "Property Location",
                ).paddingOnly(bottom: fullHeight * 0.02),
                CustomDropdown(
                  backgroundDecoration: true,
                  labelText:
                      controller.propertyLocation.isEmpty
                          ? ""
                          : "Property Location",
                  value:
                      controller.propertyLocation.isEmpty
                          ? null
                          : controller.propertyLocation,

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
                    controller.propertyLocation = v.toString();
                  },
                ).paddingOnly(bottom: fullHeight * 0.025),
                MainText(
                  text: "Property Condition",
                ).paddingOnly(bottom: fullHeight * 0.02),
                CustomDropdown(
                  backgroundDecoration: true,
                  labelText:
                      controller.propertyCondition.isEmpty
                          ? ""
                          : "Property Condition".tr,
                  value:
                      controller.propertyCondition.isEmpty
                          ? null
                          : controller.propertyCondition,

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
                    controller.propertyCondition = v.toString();
                  },
                ).paddingOnly(bottom: fullHeight * 0.05),
              ],
            ),
          ),
          CustomButton(
            onPressed: () {
              AppNavigator.push(const MortgageSummaryView());
            },
            text: "Next",
          ).paddingOnly(bottom: fullHeight * 0.05),
        ],
      ).paddingSymmetric(
        horizontal: horizontalPagePadding,
        vertical: verticalPagePadding,
      ),
    );
  }
}
