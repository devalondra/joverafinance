import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/screens/business_loan/controller/business_loan_controller.dart';
import 'package:jovera_finance/screens/business_loan/view/business_loan_apply_as_view.dart';
import 'package:jovera_finance/screens/business_loan/widget/background_decoration.dart';
import 'package:jovera_finance/screens/business_loan/widget/calculator_slider.dart';
import 'package:jovera_finance/screens/business_loan/widget/heading_row.dart';
import 'package:jovera_finance/screens/main_drawer/view/contact_us_view.dart';

import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class BusinessLoanCalculatorView extends GetView<BusinessLoanController> {
  const BusinessLoanCalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          SizedBox(height: verticalPagePadding * 2),
          CustomPageTitle(back: true, notification: false, title: "Calculator"),
          Expanded(
            child: ListView(
              children: [
                Obx(
                  () => BackgroundDecoration(
                    child: Column(
                      children: [
                        HeadingRow(
                          heading: "Amount",
                          value: "AED ${controller.loanAmount.value.round()}",
                        ),
                        CalculatorSlider(
                          controller: controller,
                          max: 1000000,
                          isDouble: false,
                          min: 50000,
                          onChanged: (v) {
                            controller.loanAmount.value = double.parse(
                              v.toStringAsFixed(2),
                            );
                          },
                          value: controller.loanAmount.value,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: fullHeight * 0.02),
                Obx(
                  () => BackgroundDecoration(
                    child: Column(
                      children: [
                        HeadingRow(
                          heading: "Payment Period",
                          value: "${controller.paymentPeriod.value} Months",
                        ),
                        CalculatorSlider(
                          isDouble: false,
                          controller: controller,
                          max:
                              controller.paymentMaxPeriod.value.roundToDouble(),

                          min:
                              controller.applicantType.value == "Investor"
                                  ? 12
                                  : 6,
                          onChanged: (v) {
                            controller.paymentPeriod.value = v.round();
                          },
                          value: controller.paymentPeriod.value.toDouble(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: fullHeight * 0.02),
                Obx(
                  () => BackgroundDecoration(
                    child: Column(
                      children: [
                        HeadingRow(
                          heading: "Annual Interest Rate",
                          value: "${controller.interestRate.value} %",
                        ),
                        CalculatorSlider(
                          controller: controller,
                          isDouble: true,
                          max: 25,
                          min:
                              controller.applicantType.value == "Investor"
                                  ? 8.2
                                  : 3.75,
                          onChanged: (v) {
                            controller.interestRate.value = double.parse(
                              v.toStringAsFixed(1),
                            );
                          },
                          value: controller.interestRate.value.toDouble(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: fullHeight * 0.02),
          Obx(
            () => BackgroundDecoration(
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
          ),
          SizedBox(height: fullHeight * 0.01),
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => BackgroundDecoration(
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
                                          (controller.paymentPeriod.value *
                                              12)) -
                                      controller.loanAmount.value)
                                  .round()
                                  .toString(),
                        ),
                      ],
                    ).paddingSymmetric(vertical: fullHeight * 0.01),
                  ),
                ),
              ),
              SizedBox(width: fullWidth * 0.02),
              Expanded(
                child: Obx(
                  () => BackgroundDecoration(
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
                                      (controller.paymentPeriod.value * 12))
                                  .round()
                                  .toString(),
                        ),
                      ],
                    ).paddingSymmetric(vertical: fullHeight * 0.01),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: fullHeight * 0.02),
          controller.authManager.isLogged.value
              ? CustomButton(
                onPressed: () {
                  Get.to(() => BusinessLoanApplyAsView());
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
                  // cont.onItemTapped(4);
                  // Get.until(
                  //   (route) => Get.currentRoute == '/BottomNavigationBarView',
                  // );
                  goToLoginScreen();
                },
                text: "Login to Apply",
              ),
          SizedBox(height: fullHeight * 0.01),
          CustomButton(
            color: AppColors.backgroundColor,
            borderColor: AppColors.backgroundColor,
            onPressed: () {
              Get.to(() => ContactUsView());
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
