import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/home/controller/home_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/home/widget/dots_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/home/widget/offers_carousel.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Row(
                    children: [
                      Container(
                        height: fullWidth * 0.17,
                        width: fullWidth * 0.17,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.darkGrey),
                          image:
                              controller.authManager.appUser.value.picture !=
                                          null &&
                                      controller
                                              .authManager
                                              .appUser
                                              .value
                                              .picture !=
                                          ""
                                  ? DecorationImage(
                                    image: NetworkImage(
                                      controller
                                          .authManager
                                          .appUser
                                          .value
                                          .picture!,
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                  : DecorationImage(
                                    image: AssetImage(
                                      "assets/images/jovera_logo.png",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                        ),
                      ),
                      SizedBox(width: fullWidth * 0.03),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          controller.authManager.isLogged.value
                              ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      MainText(text: 'Welcome Back'.tr),
                                      SizedBox(width: fullWidth * 0.02),
                                      Icon(
                                        Icons.waving_hand,
                                        color: AppColors.primary,
                                      ),
                                    ],
                                  ),
                                  MainText(
                                    text:
                                        controller
                                                    .authManager
                                                    .appUser
                                                    .value
                                                    .name ==
                                                null
                                            ? ""
                                            : controller
                                                .authManager
                                                .appUser
                                                .value
                                                .name!,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              )
                              : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MainText(text: 'Easy Loans'.tr),
                                  SizedBox(width: fullWidth * 0.02),
                                  Icon(
                                    Icons.waving_hand,
                                    color: AppColors.primary,
                                  ),
                                ],
                              ),
                        ],
                      ),
                    ],
                  ).paddingSymmetric(vertical: fullHeight * 0.01),
                ),
                InkWell(
                  onTap: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  child: Icon(Icons.menu, color: AppColors.grey),
                ),

           
              ],
            ),

            SizedBox(height: fullHeight * 0.01),
            OffersCarousel(controller: controller),
            DotsController(),
            SizedBox(height: fullHeight * 0.015),
            MainText(
              text: "Quick and Easy Loans for Your\nFinancial Needs.".tr,
              color: AppColors.white,
              textAlign: TextAlign.center,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: fullHeight * 0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    BottomNavigationBarController cont = Get.find();
                    cont.selectedIndex.value = 1;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: fullWidth * 0.03,
                      vertical: fullWidth * 0.012,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(fullWidth * 0.01),
                    ),
                    child: MainText(
                      text: "Apply Now",
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: fullHeight * 0.015),
            Row(
              children: [
                MainText(
                  text: "Services".tr,
                  color: AppColors.white,
                  textAlign: TextAlign.left,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            SizedBox(height: fullHeight * 0.015),
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
                    onTap: () => controller.servicesList[index].onTap(),
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
                          SvgPicture.asset(
                            controller.servicesList[index].iconPath,
                          ),
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
        ),
      ),
    );
  }
}
