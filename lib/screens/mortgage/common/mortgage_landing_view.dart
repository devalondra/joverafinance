import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/screens/business_loan/widget/background_decoration.dart';
import 'package:jovera_finance/screens/mortgage/calculator/mortgage_calculator_view.dart';
import 'package:jovera_finance/screens/mortgage/common/mortgage_information_view.dart';
import 'package:jovera_finance/screens/mortgage/controller/mortgage_controller.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class MortgageLandingView extends GetView<MortgageController> {
  const MortgageLandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 0),
        children: [
          Stack(
            fit: StackFit.loose,
            children: [
              SizedBox(
                width: fullWidth,
                child: Image.asset(
                  "assets/images/mortgage_background_image.png",
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomPageTitle(
                    back: true,
                    notification: false,
                    title: "",
                  ).paddingSymmetric(
                    horizontal: horizontalPagePadding,
                    vertical: verticalPagePadding * 2,
                  ),
                  SizedBox(height: fullHeight * 0.2),

                  MainText(
                    text:
                        "Achieve your dream of owning your home with flexible & easy Mortgage financing.",
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
                            if (controller.authManager.isLogged.value) {
                              Get.lazyPut<MortgageController>(
                                () => MortgageController(),
                              );
                              Get.to(() => MortgageInformationView());
                            } else {
                              Get.back();

                              BottomNavigationBarController cont = Get.find();
                              cont.selectedIndex.value = 4;
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
                            Get.lazyPut<MortgageController>(
                              () => MortgageController(),
                            );
                            Get.to(() => MortgageCalculatorView());
                          },
                          text: "Calculator",
                        ),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: horizontalPagePadding),
                ],
              ),
            ],
          ),

          Column(
            children: [
              Row(
                children: [
                  MainText(
                    text: "What we offer",
                    fontSize: 22,

                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),

              ListView.builder(
                padding: EdgeInsets.symmetric(vertical: fullHeight * 0.01),
                shrinkWrap: true,
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
                  ).paddingOnly(bottom: fullHeight * 0.008);
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
    "New purchase",
    "Final Payment",
    "Buyout for Mortgage loan",
    "Refinance your property with equity cash",
    "Plot and land purchase",
    "Under construction residential properties",
    "Final Payment Financing",
  ];
}
