import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/track/controller/dashboard_controller.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class ApplicationCard extends StatelessWidget {
  const ApplicationCard({
    super.key,
    required this.controller,
    required this.index,
  });
  final DashboardController controller;
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.selectedVisaApplicationModel.value =
            controller.myVisaApplications[index];
        controller.getLeadById(index);
      },
      child: Container(
        padding: EdgeInsets.all(fullWidth * 0.04),
        margin: EdgeInsets.only(bottom: fullWidth * 0.03),
        decoration: BoxDecoration(
          color: AppColors.black2,
          borderRadius: BorderRadius.circular(fullWidth * 0.03),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainText(
                  text: "${controller.myVisaApplications[index].orderNumber}",
                  fontSize: 14.spMin,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: fullWidth * 0.06,
                    vertical: fullHeight * 0.006,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors:
                          controller.myVisaApplications[index].status ==
                                  "Rejected"
                              ? [
                                const Color.fromARGB(255, 116, 33, 33),
                                AppColors.primaryDark,
                              ]
                              : controller.myVisaApplications[index].status ==
                                  "Approved"
                              ? [
                                const Color.fromARGB(255, 11, 57, 17),
                                AppColors.green,
                              ]
                              : [
                                const Color.fromARGB(255, 68, 50, 11),
                                AppColors.primary,
                              ],
                    ),

                    borderRadius: BorderRadius.circular(fullWidth * 0.02),
                  ),

                  child: MainText(
                    text:
                        controller.myVisaApplications[index].isRejected == true
                            ? "Track"
                            : controller.myVisaApplications[index].status ?? "",
                    textAlign: TextAlign.center,
                    fontSize: 14,
                  ),
                ),
              ],
            ).paddingSymmetric(vertical: fullHeight * 0.005),
            MainText(
              text:
                  controller.myVisaApplications[index].isRejected == true
                      ? "Your application is rejected"
                      : "${controller.myVisaApplications[index].description?.tr ?? 00}",
              fontSize: 13.spMin,
              color:
                  controller.myVisaApplications[index].isRejected == true
                      ? AppColors.primaryDark
                      : controller.myVisaApplications[index].status ==
                          "Approved"
                      ? AppColors.green
                      : AppColors.primary,
            ).paddingSymmetric(vertical: fullHeight * 0.005),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainText(
                  text:
                      "${controller.myVisaApplications[index].submittedAt?.substring(0, 10)}",

                  fontSize: 12.spMin,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.lightGrey,

                  size: fullWidth * 0.03,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
