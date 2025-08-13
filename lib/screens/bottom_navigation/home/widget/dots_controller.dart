import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/home/controller/home_controller.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';

class DotsController extends StatelessWidget {
  const DotsController({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder:
          (controller) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              controller.offersCarouselList.length,
              (index) => Obx(
                () => AnimatedContainer(
                  margin: const EdgeInsets.all(5),
                  duration: const Duration(milliseconds: 300),
                  width:
                      controller.currentPage.value == index
                          ? fullWidth * 0.1
                          : fullWidth * 0.025,
                  height: fullWidth * 0.025,
                  decoration: BoxDecoration(
                    color:
                        controller.currentPage.value == index
                            ? AppColors.primary
                            : AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
