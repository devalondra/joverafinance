import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/services/controller/services_controller.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class ServicesView extends GetView<ServicesController> {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CustomPageTitle(back: false, notification: false, title: "Services"),
        SizedBox(height: verticalPagePadding),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.1,
          ),
          itemCount: controller.servicesList.length,
          itemBuilder: (context, index) {
            return Obx(
              () => InkWell(
                onTap: () {
                  controller.selectedService.value = index;
                  controller.servicesList[index].onTap();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.black2,
                    borderRadius: BorderRadius.circular(fullWidth * 0.04),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors:
                          controller.selectedService.value == index
                              ? [
                                const Color.fromARGB(255, 115, 77, 8),
                                AppColors.primary,
                              ]
                              : [AppColors.black2, AppColors.black2],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(controller.servicesList[index].iconPath),
                      MainText(text: controller.servicesList[index].title),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    ).paddingSymmetric(
      horizontal: horizontalPagePadding,
      vertical: verticalPagePadding,
    );
  }
}
