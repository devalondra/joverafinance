import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/screens/main_drawer/view/contact_us_view.dart';
import 'package:jovera_finance/screens/personal_loan/view/personal_loan_information_view.dart';

import 'package:jovera_finance/screens/personal_loan/controller/personal_loan_controller.dart';
import 'package:jovera_finance/screens/personal_loan/widget/background_decoration.dart';
import 'package:jovera_finance/screens/personal_loan/widget/calculator_slider.dart';
import 'package:jovera_finance/screens/personal_loan/widget/calculator_tab.dart';
import 'package:jovera_finance/screens/personal_loan/widget/heading_row.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/utilities/extensions/widget_extensions.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class PersonalLoanCalculatorView extends ConsumerWidget {
  const PersonalLoanCalculatorView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(personalLoanControllerProvider.notifier);
    ref.watch(personalLoanControllerProvider);
    final isLogged = ref.watch(authManagerProvider).isLogged;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          SizedBox(height: verticalPagePadding * 2),
          CustomPageTitle(back: true, notification: false, title: "Calculator"),
          Expanded(
            child: ListView(
              children: [
                controller.applicantType == "Investor"
                    ? SizedBox()
                    : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CalculatorTab(
                          controller: controller,
                          title: "UAE National",
                        ),
                        CalculatorTab(
                          controller: controller,
                          title: "UAE Resident",
                        ),
                      ],
                    ),
                SizedBox(height: fullHeight * 0.02),
                BackgroundDecoration(
                  child: Column(
                    children: [
                      HeadingRow(
                        heading: "Amount",
                        value: "AED ${controller.loanAmount.round()}",
                      ),
                      CalculatorSlider(
                        controller: controller,
                        max: 1000000,
                        isDouble: false,
                        min: 50000,
                        onChanged: (v) {
                          controller.loanAmount = double.parse(
                            v.toStringAsFixed(2),
                          );
                        },
                        value: controller.loanAmount,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: fullHeight * 0.02),
                BackgroundDecoration(
                  child: Column(
                    children: [
                      HeadingRow(
                        heading: "Payment Period",
                        value:
                            "${controller.paymentPeriod} ${"Months".tr}",
                      ),
                      CalculatorSlider(
                        isDouble: false,
                        controller: controller,
                        max: controller.paymentMaxPeriod.roundToDouble(),

                        min:
                            controller.applicantType == "Investor" ? 12 : 6,
                        onChanged: (v) {
                          controller.paymentPeriod = v.round();
                        },
                        value: controller.paymentPeriod.toDouble(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: fullHeight * 0.02),
                BackgroundDecoration(
                  child: Column(
                    children: [
                      HeadingRow(
                        heading: "Annual Interest Rate",
                        value: "${controller.interestRate} %",
                      ),
                      CalculatorSlider(
                        controller: controller,
                        isDouble: true,
                        max: 25,
                        min:
                            controller.applicantType == "Investor"
                                ? 8.2
                                : 3.75,
                        onChanged: (v) {
                          controller.interestRate = double.parse(
                            v.toStringAsFixed(1),
                          );
                        },
                        value: controller.interestRate.toDouble(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: fullHeight * 0.02),
          BackgroundDecoration(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MainText(
                      text: "Monthly Installment",
                      color: AppColors.primary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),

                MainText(text: "${controller.calculateEMI().round()} AED"),
              ],
            ).paddingSymmetric(vertical: fullHeight * 0.01),
          ),
          SizedBox(height: fullHeight * 0.01),
          Row(
            children: [
              Expanded(
                child: BackgroundDecoration(
                  child: Column(
                    children: [
                      MainText(
                        text: "Total Interest",
                        color: AppColors.primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),

                      MainText(
                        text:
                            ((controller.calculateEMI() *
                                        (controller.paymentPeriod * 12)) -
                                    controller.loanAmount)
                                .round()
                                .toString(),
                      ),
                    ],
                  ).paddingSymmetric(vertical: fullHeight * 0.01),
                ),
              ),
              SizedBox(width: fullWidth * 0.02),
              Expanded(
                child: BackgroundDecoration(
                  child: Column(
                    children: [
                      MainText(
                        text: "Total Amount",
                        color: AppColors.primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),

                      MainText(
                        text:
                            (controller.calculateEMI() *
                                    (controller.paymentPeriod * 12))
                                .round()
                                .toString(),
                      ),
                    ],
                  ).paddingSymmetric(vertical: fullHeight * 0.01),
                ),
              ),
            ],
          ),
          SizedBox(height: fullHeight * 0.02),
          isLogged
              ? CustomButton(
                onPressed: () {
                  AppNavigator.push(const PersonalLoanInformationView());
                },
                text: "Apply",
              )
              : CustomButton(
                onPressed: () {
                  // Get.offAll(
                  //   () => BottomnavigationBarView(),
                  //   binding: BottomNavigationBarBinding(),
                  // );

                  // BottomNavigationBarController cont = Get.find();
                  // cont.selectedIndex.value = 4;
                  goToLoginScreen(ref.read);
                },
                text: "Login to Apply",
              ),
          SizedBox(height: fullHeight * 0.01),
          CustomButton(
            color: AppColors.backgroundColor,
            borderColor: AppColors.backgroundColor,
            onPressed: () {
              AppNavigator.push(const ContactUsView());
            },
            icon: SvgPicture.asset("assets/icons/chat_icon.svg"),
            text: "Get Free Consultation",
          ),
          SizedBox(height: verticalPagePadding * 2),
        ],
      ).paddingSymmetric(
        vertical: verticalPagePadding,
        horizontal: horizontalPagePadding,
      ),
    );
  }
}
