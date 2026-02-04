import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/screens/business_loan/calculator/business_loan_calculator_view.dart';
import 'package:jovera_finance/screens/business_loan/controller/business_loan_controller.dart';
import 'package:jovera_finance/screens/business_loan/view/business_loan_apply_as_view.dart';
import 'package:jovera_finance/screens/business_loan/widget/background_decoration.dart';

import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/utilities/extensions/widget_extensions.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class BusinessLoanLandingView extends ConsumerWidget {
  const BusinessLoanLandingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(businessLoanControllerProvider);
    final isLogged = ref.watch(authManagerProvider).isLogged;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          SizedBox(
            width: fullWidth,
            child: Image.asset(
              "assets/images/business_loan_background_image.png",
              height: fullHeight * 0.5,

              fit: BoxFit.fitWidth,
            ),
          ),
          Image.asset(
            "assets/images/overlay.png",
            height: fullHeight * 0.5,
            width: fullWidth,
          ),
          Column(
            children: [
              CustomPageTitle(
                back: true,
                notification: false,
                title: "",
              ).paddingSymmetric(vertical: verticalPagePadding * 2),
              SizedBox(height: fullHeight * 0.18),

              MainText(
                text:
                    "Empower Your Business with Fast & Flexible Financing Solutions",
                fontSize: 18,
                textAlign: TextAlign.center,

                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: fullHeight * 0.02),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        if (kDebugMode) print("hjhgjhj");
                        if (isLogged) {
                          AppNavigator.push(
                            const BusinessLoanApplyAsView(),
                          );
                        } else {
                          goToLoginScreen(ref.read);
                        }
                      },
                      text: "Apply",
                    ),
                  ),
                  SizedBox(width: fullWidth * 0.05),
                  Expanded(
                    child: CustomButton(
                      color: AppColors.transparent,
                      borderColor: AppColors.white,
                      onPressed: () {
                        if (kDebugMode) print("hjhgjhj");
                        AppNavigator.push(
                          const BusinessLoanCalculatorView(),
                        );
                      },
                      text: "Calculator",
                    ),
                  ),
                ],
              ),
              SizedBox(height: fullHeight * 0.05),
              Row(
                children: [
                  MainText(
                    text: "What we offer",
                    fontSize: 22,

                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              SizedBox(height: fullHeight * 0.02),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(0),
                scrollDirection: Axis.vertical,
                itemCount: instructionsList.length,
                itemBuilder: (context, index) {
                  return BackgroundDecoration(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: fullWidth * 0.08,
                          color: AppColors.primary,
                        ).paddingOnly(top: fullHeight * 0.005),
                        SizedBox(width: fullWidth * 0.04),
                        Expanded(
                          child: MainText(text: instructionsList[index]),
                        ),
                      ],
                    ),
                  ).paddingOnly(bottom: fullHeight * 0.01);
                },
              ),
            ],
          ).paddingSymmetric(
            horizontal: horizontalPagePadding,
            vertical: verticalPagePadding,
          ),
        ],
      ),
    );
  }

  static const List instructionsList = [
    "SME - Small, Medium Company",
    "Cash",
    "Car Loan",
    "Equipment Loan",
  ];
}
