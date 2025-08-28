import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/track/controller/dashboard_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/track/model/visa_application_model.dart';
import 'package:jovera_finance/screens/bottom_navigation/track/widget/tracking_card.dart';
import 'package:jovera_finance/screens/bottom_navigation/track/widget/tracking_details_row.dart';
import 'package:jovera_finance/screens/business_loan/widget/background_decoration.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/background.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class TrackingView extends GetView<DashboardController> {
  const TrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    VisaApplicationModel lead = controller.selectedVisaApplicationModel.value;
    // lead.status = "Funded";
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Obx(
          () => Background(
            appLoadingController: controller.appLoadingController,
            child:
                controller.isLoading.value
                    ? Align(
                      alignment: Alignment.topCenter,
                      child: CustomPageTitle(
                        title: "Loan Tracking".tr,
                        back: true,
                        notification: false,
                      ),
                    )
                    : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomPageTitle(
                                title: "Loan Tracking".tr,
                                back: true,
                                notification: false,
                              ),
                              SizedBox(height: fullHeight * 0.04),
                              BackgroundDecoration(
                                child: Row(
                                  children: [
                                    MainText(
                                      text: "Order Number".tr,
                                      fontSize: 12.spMin,
                                    ),
                                    SizedBox(width: fullWidth * 0.01),
                                    MainText(
                                      text: " : ${lead.orderNumber ?? 000}",
                                      fontSize: 12.spMin,
                                    ),
                                  ],
                                ).paddingAll(fullHeight * 0.01),
                              ),
                              SizedBox(height: fullHeight * 0.02),
                              TrackingDetailsRow(
                                title: "Type of Loan",
                                value: lead.typeOfLoan ?? "",
                              ),
                              TrackingDetailsRow(
                                title: "Submission Date",
                                value: lead.submittedAt?.substring(0, 10) ?? "",
                              ),
                              TrackingDetailsRow(
                                title: "Current Status",
                                value:
                                    lead.isRejected == true
                                        ? "Rejected"
                                        : lead.status ?? "",
                              ),
                              TrackingDetailsRow(
                                title: "Sales Person",
                                value: lead.salesPerson ?? "",
                              ),
                              SizedBox(height: fullHeight * 0.03),
                              TrackingCard(
                                iconPath: "assets/icons/apply_icon.svg",
                                subtitle: "Submission successful".tr,
                                title: "Application Received".tr,
                                status:
                                    lead.status == "Application Received" ||
                                    lead.status == "Under Process" ||
                                    lead.status == "Contract Sign" ||
                                    lead.status == "Approved" ||
                                    lead.status == "Funded",
                              ),
                              TrackingCard(
                                iconPath: "assets/icons/under_process_icon.svg",
                                subtitle: "Submission successful".tr,
                                title: "Under Process".tr,
                                status:
                                    lead.status == "Under Process" ||
                                    lead.status == "Contract Sign" ||
                                    lead.status == "Approved" ||
                                    lead.status == "Funded",
                              ),
                              lead.isRejected == true &&
                                      lead.status == "Under Process"
                                  ? TrackingCard(
                                    iconPath: "assets/icons/rejected_icon.svg",
                                    subtitle: "Submission successful".tr,
                                    title: "Rejected".tr,
                                    color: AppColors.primaryDark,
                                    status: true,
                                  )
                                  : TrackingCard(
                                    iconPath:
                                        "assets/icons/contract_sign_icon.svg",
                                    subtitle: "Submission successful".tr,
                                    title: "Contract Sign".tr,
                                    status:
                                        lead.status == "Contract Sign" ||
                                        lead.status == "Approved" ||
                                        lead.status == "Funded",
                                  ),
                              lead.isRejected == true &&
                                      lead.status == "Contract Sign"
                                  ? TrackingCard(
                                    iconPath: "assets/icons/rejected_icon.svg",
                                    subtitle: "Submission successful".tr,
                                    title: "Rejected".tr,
                                    color: AppColors.primaryDark,
                                    status: true,
                                  )
                                  : lead.isRejected == true &&
                                      (lead.status == "Application Recieved" ||
                                          lead.status == "Under Process")
                                  ? SizedBox()
                                  : TrackingCard(
                                    iconPath: "assets/icons/approved_icon.svg",
                                    subtitle: "Submission successful".tr,
                                    title: "Approved".tr,
                                    status:
                                        lead.status == "Approved" ||
                                        lead.status == "Funded",
                                  ),
                              lead.isRejected == true &&
                                      lead.status == "Approved"
                                  ? TrackingCard(
                                    iconPath: "assets/icons/rejected_icon.svg",
                                    subtitle: "Submission successful".tr,
                                    title: "Rejected".tr,
                                    color: AppColors.primaryDark,
                                    status: true,
                                  )
                                  : lead.isRejected == true &&
                                      (lead.status == "Contract Sign" ||
                                          lead.status == "Under Process")
                                  ? SizedBox()
                                  : TrackingCard(
                                    iconPath: "assets/icons/funded_icon.svg",
                                    subtitle: "Submission successful".tr,
                                    title: "Funded".tr,
                                    status: lead.status == "Funded",
                                  ),
                            ],
                          ),
                        ),

                        CustomButton(
                          onPressed: () {
                            goToHomeScreen();
                          },
                          color: AppColors.backgroundColor,
                          borderColor: AppColors.white,
                          text: "Home Page".tr,
                        ).paddingOnly(bottom: fullHeight * 0.005),
                      ],
                    ).paddingSymmetric(
                      horizontal: horizontalPagePadding,
                      vertical: verticalPagePadding,
                    ),
          ),
        ),
      ),
    );
  }
}
