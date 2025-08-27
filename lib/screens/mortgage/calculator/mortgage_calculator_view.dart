import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/screens/main_drawer/view/contact_us_view.dart';
import 'package:jovera_finance/screens/mortgage/common/mortgage_information_view.dart';
import 'package:jovera_finance/screens/mortgage/controller/mortgage_controller.dart';
import 'package:jovera_finance/screens/mortgage/widget/background_decoration.dart';
import 'package:jovera_finance/screens/mortgage/widget/calculator_slider.dart';
import 'package:jovera_finance/screens/mortgage/widget/calculator_tab.dart';
import 'package:jovera_finance/screens/mortgage/widget/heading_row.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class MortgageCalculatorView extends GetView<MortgageController> {
  const MortgageCalculatorView({super.key});

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
                Row(
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
                Obx(
                  () => BackgroundDecoration(
                    child: Column(
                      children: [
                        HeadingRow(
                          heading: "Property Price",
                          value:
                              "AED ${controller.propertyPrice.value.round()}",
                        ),
                        CalculatorSlider(
                          controller: controller,
                          max: 100000000,
                          min: 2000000,
                          onChanged: (v) {
                            controller.advancePayment.value =
                                controller.advancePercentage.value *
                                double.parse(v.toStringAsFixed(2));
                            controller.propertyPrice.value = double.parse(
                              v.toStringAsFixed(2),
                            );
                          },
                          value: controller.propertyPrice.value,
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
                          value: "${controller.propertyPeriod.value} Years",
                        ),
                        CalculatorSlider(
                          controller: controller,
                          max: 25,
                          min: 1,
                          onChanged: (v) {
                            controller.propertyPeriod.value = v.round();
                          },
                          value: controller.propertyPeriod.value.toDouble(),
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
                          heading: "Advance Payment",
                          value:
                              "${controller.advancePayment.value.round()} AED",
                        ),
                        CalculatorSlider(
                          controller: controller,
                          max: controller.propertyPrice.value,
                          min:
                              controller.advancePercentage.value *
                              controller.propertyPrice.value,
                          onChanged: (v) {
                            controller.advancePayment.value = double.parse(
                              v.toStringAsFixed(2),
                            );
                          },
                          value: controller.advancePayment.value,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: fullHeight * 0.001),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MainText(
                        text: "Minimum ${controller.advance.value}",
                        fontSize: 11,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: fullHeight * 0.01),
                BackgroundDecoration(
                  child: HeadingRow(
                    heading: "Annual Interest Rate",
                    value: "${controller.interestRate.value} %",
                  ),
                ),
                SizedBox(height: fullHeight * 0.04),
              ],
            ),
          ),
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
                                          (controller.propertyPeriod.value *
                                              12)) -
                                      (controller.propertyPrice.value -
                                          controller.advancePayment.value))
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
                                      (controller.propertyPeriod.value * 12))
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
                  Get.to(() => MortgageInformationView());
                },
                text: "Apply",
              )
              : CustomButton(
                onPressed: () {
                  // Get.back();
                  // Get.back();

                  // BottomNavigationBarController cont = Get.find();
                  // cont.selectedIndex.value = 4;
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
