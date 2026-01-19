import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
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
      body: ListView(
        children: [
          // SizedBox(height: verticalPagePadding * 2),
          CustomPageTitle(back: true, notification: false, title: "Calculator"),
          SizedBox(height: verticalPagePadding),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CalculatorTab(
                controller: controller,
                title: MortgageController.calculatorNational,
              ),
              CalculatorTab(
                controller: controller,
                title: MortgageController.calculatorResident,
              ),
              CalculatorTab(
                controller: controller,
                title: MortgageController.calculatorNonResident,
              ),
              // Legacy tabs (no non-resident).
              // CalculatorTab(
              //   controller: controller,
              //   title: "UAE National",
              // ),
              // CalculatorTab(
              //   controller: controller,
              //   title: "UAE Resident",
              // ),
            ],
          ),
          SizedBox(height: fullHeight * 0.02),
          Obx(() {
            final String priceText =
                controller.propertyPrice.value.round().toString();
            if (!controller.priceInputFocusNode.hasFocus &&
                controller.priceInputController.text != priceText) {
              controller.priceInputController.text = priceText;
            }
            void commitPrice(String value) {
              final double? parsed = double.tryParse(value);
              if (parsed == null) return;
              final double clamped =
                  parsed
                      .clamp(
                        MortgageController.mortgagePriceMin,
                        MortgageController.mortgagePriceMax,
                      )
                      .toDouble();
              controller.updatePropertyPrice(clamped);
              controller.priceInputController.text = clamped.round().toString();
            }
            void previewPrice(String value) {
              if (value.isEmpty) {
                controller.updatePropertyPrice(
                  MortgageController.mortgagePriceMin,
                );
                return;
              }
              final double? parsed = double.tryParse(value);
              if (parsed == null) return;
              final double next =
                  parsed >= MortgageController.mortgagePriceMin &&
                          parsed <= MortgageController.mortgagePriceMax
                      ? parsed
                      : MortgageController.mortgagePriceMin;
              controller.updatePropertyPrice(next);
            }

            return BackgroundDecoration(
              child: Column(
                children: [
                  HeadingRow(
                    heading: "Purchase Price",
                    // Legacy label: "Property Price".
                    value: "AED ${controller.propertyPrice.value.round()}",
                    inputController: controller.priceInputController,
                    focusNode: controller.priceInputFocusNode,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    prefixText: "AED ",
                    onSubmitted: commitPrice,
                    onEditingComplete:
                        () => commitPrice(controller.priceInputController.text),
                    onChanged: previewPrice,
                  ),
                  CalculatorSlider(
                    controller: controller,
                    max: MortgageController.mortgagePriceMax,
                    min: MortgageController.mortgagePriceMin,
                    onChanged: (v) {
                      controller.updatePropertyPrice(
                        double.parse(v.toStringAsFixed(2)),
                      );
                      // Legacy logic (percentage based).
                      // controller.advancePayment.value =
                      //     controller.advancePercentage.value *
                      //     double.parse(v.toStringAsFixed(2));
                      // controller.propertyPrice.value = double.parse(
                      //   v.toStringAsFixed(2),
                      // );
                    },
                    value: controller.propertyPrice.value,
                  ),
                ],
              ),
            );
          }),
          SizedBox(height: fullHeight * 0.02),
          Obx(() {
            final String yearsText = controller.propertyPeriod.value.toString();
            if (!controller.yearsInputFocusNode.hasFocus &&
                controller.yearsInputController.text != yearsText) {
              controller.yearsInputController.text = yearsText;
            }
            void commitYears(String value) {
              final int? parsed = int.tryParse(value);
              if (parsed == null) return;
              final int clamped =
                  parsed
                      .clamp(
                        MortgageController.mortgageYearsMin,
                        MortgageController.mortgageYearsMax,
                      )
                      .toInt();
              controller.propertyPeriod.value = clamped;
              controller.yearsInputController.text = clamped.toString();
            }
            void previewYears(String value) {
              if (value.isEmpty) {
                controller.propertyPeriod.value =
                    MortgageController.mortgageYearsMin;
                return;
              }
              final int? parsed = int.tryParse(value);
              if (parsed == null) return;
              final int next =
                  parsed >= MortgageController.mortgageYearsMin &&
                          parsed <= MortgageController.mortgageYearsMax
                      ? parsed
                      : MortgageController.mortgageYearsMin;
              controller.propertyPeriod.value = next;
            }

            return BackgroundDecoration(
              child: Column(
                children: [
                  HeadingRow(
                    heading: "Payment Period",
                    value: "${controller.propertyPeriod.value} Years",
                    inputController: controller.yearsInputController,
                    focusNode: controller.yearsInputFocusNode,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    suffixText: 'Years',
                    onSubmitted: commitYears,
                    onEditingComplete:
                        () => commitYears(controller.yearsInputController.text),
                    onChanged: previewYears,
                  ),
                  CalculatorSlider(
                    controller: controller,
                    max: MortgageController.mortgageYearsMax.toDouble(),
                    min: MortgageController.mortgageYearsMin.toDouble(),
                    onChanged: (v) {
                      controller.propertyPeriod.value = v.round();
                    },
                    value: controller.propertyPeriod.value.toDouble(),
                  ),
                ],
              ),
            );
          }),
          SizedBox(height: fullHeight * 0.02),
          Obx(() {
            final double price = controller.propertyPrice.value;
            final double advancePercent =
                price == 0
                    ? 0
                    : (controller.advancePayment.value / price) * 100;
            final String advanceText =
                controller.advancePayment.value.round().toString();
            if (!controller.advanceInputFocusNode.hasFocus &&
                controller.advanceInputController.text != advanceText) {
              controller.advanceInputController.text = advanceText;
            }
            void commitAdvance(String value) {
              final double? parsed = double.tryParse(value);
              if (parsed == null) return;
              final double clamped =
                  parsed
                      .clamp(controller.advanceMin, controller.advanceMax)
                      .toDouble();
              controller.updateAdvancePayment(clamped);
              controller.advanceInputController.text =
                  clamped.round().toString();
            }
            void previewAdvance(String value) {
              if (value.isEmpty) {
                controller.updateAdvancePayment(controller.advanceMin);
                return;
              }
              final double? parsed = double.tryParse(value);
              if (parsed == null) return;
              final double next =
                  parsed >= controller.advanceMin &&
                          parsed <= controller.advanceMax
                      ? parsed
                      : controller.advanceMin;
              controller.updateAdvancePayment(next);
            }

            return BackgroundDecoration(
              child: Column(
                children: [
                  HeadingRow(
                    heading: "Down Payment",
                    value:
                        "AED ${controller.advancePayment.value.round()} (${advancePercent.round()}%)",
                    inputController: controller.advanceInputController,
                    focusNode: controller.advanceInputFocusNode,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    prefixText: "AED ",
                    suffixText: " ${advancePercent.round()}%",
                    onSubmitted: commitAdvance,
                    onEditingComplete:
                        () => commitAdvance(
                          controller.advanceInputController.text,
                        ),
                    onChanged: previewAdvance,
                  ),
                  CalculatorSlider(
                    controller: controller,
                    max: controller.advanceMax,
                    min: controller.advanceMin,
                    onChanged: (v) {
                      controller.updateAdvancePayment(
                        double.parse(v.toStringAsFixed(2)),
                      );
                    },
                    value: controller.advancePayment.value,
                  ),
                ],
              ),
            );
          }),
          SizedBox(height: fullHeight * 0.02),
          Obx(() {
            final double price = controller.propertyPrice.value;
            final double loanPercent =
                price == 0 ? 0 : (controller.loanAmount.value / price) * 100;
            final String loanText =
                controller.loanAmount.value.round().toString();
            if (!controller.loanInputFocusNode.hasFocus &&
                controller.loanInputController.text != loanText) {
              controller.loanInputController.text = loanText;
            }
            void commitLoan(String value) {
              final double? parsed = double.tryParse(value);
              if (parsed == null) return;
              final double clamped =
                  parsed
                      .clamp(controller.loanMin, controller.loanMax)
                      .toDouble();
              controller.updateLoanAmount(clamped);
              controller.loanInputController.text = clamped.round().toString();
            }
            void previewLoan(String value) {
              if (value.isEmpty) {
                controller.updateLoanAmount(controller.loanMin);
                return;
              }
              final double? parsed = double.tryParse(value);
              if (parsed == null) return;
              final double next =
                  parsed >= controller.loanMin && parsed <= controller.loanMax
                      ? parsed
                      : controller.loanMin;
              controller.updateLoanAmount(next);
            }

            return BackgroundDecoration(
              child: Column(
                children: [
                  HeadingRow(
                    heading: "Loan Amount",
                    value:
                        "AED ${controller.loanAmount.value.round()} (${loanPercent.round()}%)",
                    inputController: controller.loanInputController,
                    focusNode: controller.loanInputFocusNode,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    prefixText: "AED ",
                    suffixText: " ${loanPercent.round()}%",
                    onSubmitted: commitLoan,
                    onEditingComplete:
                        () => commitLoan(controller.loanInputController.text),
                    onChanged: previewLoan,
                  ),
                  CalculatorSlider(
                    controller: controller,
                    max: controller.loanMax,
                    min: controller.loanMin,
                    onChanged: (v) {
                      controller.updateLoanAmount(
                        double.parse(v.toStringAsFixed(2)),
                      );
                    },
                    value: controller.loanAmount.value,
                  ),
                ],
              ),
            );
          }),
          SizedBox(height: fullHeight * 0.02),
          Obx(() {
            final String interestText = controller.interestRate.value
                .toStringAsFixed(1);
            if (!controller.interestInputFocusNode.hasFocus &&
                controller.interestInputController.text != interestText) {
              controller.interestInputController.text = interestText;
            }
            void commitInterest(String value) {
              final double? parsed = double.tryParse(value);
              if (parsed == null) return;
              final double clamped =
                  parsed
                      .clamp(
                        MortgageController.mortgageInterestMin,
                        MortgageController.mortgageInterestMax,
                      )
                      .toDouble();
              controller.interestRate.value = double.parse(
                clamped.toStringAsFixed(1),
              );
              controller.interestInputController.text = controller
                  .interestRate
                  .value
                  .toStringAsFixed(1);
            }
            void previewInterest(String value) {
              if (value.isEmpty) {
                controller.interestRate.value = MortgageController
                    .mortgageInterestMin;
                return;
              }
              final double? parsed = double.tryParse(value);
              if (parsed == null) return;
              final double next =
                  parsed >= MortgageController.mortgageInterestMin &&
                          parsed <= MortgageController.mortgageInterestMax
                      ? parsed
                      : MortgageController.mortgageInterestMin;
              controller.interestRate.value = double.parse(
                next.toStringAsFixed(1),
              );
            }

            return BackgroundDecoration(
              child: Column(
                children: [
                  HeadingRow(
                    heading: "Annual Interest Rate",
                    value:
                        "${controller.interestRate.value.toStringAsFixed(1)} %",
                    inputController: controller.interestInputController,
                    focusNode: controller.interestInputFocusNode,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    suffixText: " %",
                    onSubmitted: commitInterest,
                    onEditingComplete:
                        () => commitInterest(
                          controller.interestInputController.text,
                        ),
                    onChanged: previewInterest,
                  ),
                  CalculatorSlider(
                    controller: controller,
                    max: MortgageController.mortgageInterestMax,
                    min: MortgageController.mortgageInterestMin,
                    divisions:
                        ((MortgageController.mortgageInterestMax -
                                    MortgageController.mortgageInterestMin) *
                                10)
                            .round(),
                    onChanged: (v) {
                      controller.interestRate.value = double.parse(
                        v.toStringAsFixed(1),
                      );
                    },
                    value: controller.interestRate.value,
                  ),
                ],
              ),
            );
          }),
          // Legacy advance payment + fixed interest display.
          // Obx(
          //   () => BackgroundDecoration(
          //     child: Column(
          //       children: [
          //         HeadingRow(
          //           heading: "Advance Payment",
          //           value:
          //               "${controller.advancePayment.value.round()} AED",
          //         ),
          //         CalculatorSlider(
          //           controller: controller,
          //           max: controller.propertyPrice.value,
          //           min:
          //               controller.advancePercentage.value *
          //               controller.propertyPrice.value,
          //           onChanged: (v) {
          //             controller.advancePayment.value = double.parse(
          //               v.toStringAsFixed(2),
          //             );
          //           },
          //           value: controller.advancePayment.value,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // SizedBox(height: fullHeight * 0.001),
          // Obx(
          //   () => Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       MainText(
          //         text: "Minimum ${controller.advance.value}",
          //         fontSize: 11,
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(height: fullHeight * 0.01),
          // BackgroundDecoration(
          //   child: HeadingRow(
          //     heading: "Annual Interest Rate",
          //     value: "${controller.interestRate.value} %",
          //   ),
          // ),
          SizedBox(height: fullHeight * 0.04),

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

          // SizedBox(height: fullHeight * 0.01),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Obx(
          //         () => BackgroundDecoration(
          //           child: Column(
          //             children: [
          //               MainText(
          //                 text: "Total Interest",
          //                 color: AppColors.primary,
          //                 fontSize: 14.sp,
          //                 fontWeight: FontWeight.w600,
          //               ),

          //               MainText(
          //                 text:
          //                     ((controller.calculateEMI() *
          //                                 (controller.propertyPeriod.value *
          //                                     12)) -
          //                             controller.loanAmount.value)
          //                         .round()
          //                         .toString(),
          //               ),
          //             ],
          //           ).paddingSymmetric(vertical: fullHeight * 0.01),
          //         ),
          //       ),
          //     ),
          //     SizedBox(width: fullWidth * 0.02),
          //     Expanded(
          //       child: Obx(
          //         () => BackgroundDecoration(
          //           child: Column(
          //             children: [
          //               MainText(
          //                 text: "Total Amount",
          //                 color: AppColors.primary,
          //                 fontSize: 14.sp,
          //                 fontWeight: FontWeight.w600,
          //               ),

          //               MainText(
          //                 text:
          //                     (controller.calculateEMI() *
          //                             (controller.propertyPeriod.value * 12))
          //                         .round()
          //                         .toString(),
          //               ),
          //             ],
          //           ).paddingSymmetric(vertical: fullHeight * 0.01),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
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
          //    SizedBox(height: verticalPagePadding * 2),
        ],
      ).paddingSymmetric(
        //  vertical: verticalPagePadding,
        horizontal: horizontalPagePadding,
      ),
    );
  }
}
