import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/mortgage/controller/mortgage_controller.dart';
import 'package:jovera_finance/screens/mortgage/company/mortgage_company_documents_view.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_validators.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/utilities/extensions/widget_extensions.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';
import 'package:jovera_finance/widgets/custom_text_field.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class MortgageCompanyDetailsView extends ConsumerWidget {
  const MortgageCompanyDetailsView({super.key});

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
                  title: "Company Owner Details",
                ),
                SizedBox(height: fullHeight * 0.05),
                CustomTextField(
                  controller: controller.personalNameController,
                  hintText: "Full Name",
                  validator: (value) {
                    return AppValidators().textValidation(value);
                  },
                ).paddingOnly(bottom: fullHeight * 0.02),

                DropdownButtonFormField(
                  dropdownColor: AppColors.black2,
                  isExpanded: true,
                  iconEnabledColor: AppColors.grey,
                  decoration: InputDecoration(
                    fillColor: AppColors.black2,
                    alignLabelWithHint: true,

                    labelStyle: TextStyle(color: AppColors.grey, fontSize: 14),
                    isDense: true,
                    labelText:
                        controller.nationalityType.isEmpty
                            ? ""
                            : "Nationality".tr,
                    contentPadding: EdgeInsets.only(bottom: fullHeight * 0.01),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.grey, width: 1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.grey, width: 1),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  initialValue:
                      controller.nationalityType.isEmpty
                          ? null
                          : controller.nationalityType,

                  hint: MainText(text: "Choose", color: AppColors.lightGrey),
                  items:
                      controller.nationalities
                          .map(
                            (nationality) => DropdownMenuItem(
                              value: nationality,
                              child: MainText(
                                text: nationality,
                                color: AppColors.grey,
                              ),
                            ),
                            )
                            .toList(),

                  onChanged: (v) {
                    controller.nationalityType = v.toString();
                  },
                ).paddingOnly(bottom: fullHeight * 0.025),
                CustomTextField(
                  controller: controller.personalEmailController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Email",
                  validator: (value) {
                    return AppValidators().email(value);
                  },
                ).paddingOnly(bottom: fullHeight * 0.02),
              ],
            ),
          ),

          CustomButton(
            onPressed: () {
              AppNavigator.push(const MortgageCompanyDocumentsView());
            },
            text: "Next",
          ),
          SizedBox(height: fullHeight * 0.05),
        ],
      ).paddingSymmetric(
        horizontal: horizontalPagePadding,
        vertical: verticalPagePadding,
      ),
    );
  }
}
