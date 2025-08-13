import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(fullWidth * 0.02),
            image: DecorationImage(
              image: AssetImage("assets/images/carousal_image.png"),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   children: [
            //     MainText(
            //       text: "Get our Special Offers".tr,
            //       color: AppColors.white,
            //       fontSize: 22,
            //       fontWeight: FontWeight.w600,
            //     ),
            //   ],
            // ),

            // SizedBox(height: fullHeight * 0.01),
            // InkWell(
            //   onTap: () {
            //     BottomNavigationBarController cont = Get.find();
            //     cont.selectedIndex.value = 2;
            //   },
            //   child: Container(
            //     padding: EdgeInsets.symmetric(
            //       horizontal: fullWidth * 0.03,
            //       vertical: fullWidth * 0.012,
            //     ),
            //     decoration: BoxDecoration(
            //       color: AppColors.primary,
            //       borderRadius: BorderRadius.circular(fullWidth * 0.01),
            //     ),
            //     child: MainText(
            //       text: "Apply Now",
            //       color: AppColors.white,
            //       fontSize: 16,
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            // ),
          ],
        ).paddingAll(fullWidth * 0.05),
      ],
    ).paddingAll(fullWidth * 0.01);
  }
}
