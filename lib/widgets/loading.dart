import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/app_loading_controller.dart';

class Loading extends StatelessWidget {
  final AppLoadingController appLoading;
  const Loading({super.key, required this.appLoading});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          appLoading.isLoading.value
              ? AbsorbPointer(
                child: Center(
                  child: Container(
                    width: Get.width / 5,
                    height: Get.width / 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(fullWidth * 0.02),
                      color: const Color.fromARGB(255, 38, 38, 38),
                      boxShadow: [BoxShadow(color: AppColors.grey)],
                    ),
                    child: Stack(
                      children: [Center(child: appLoading.loadingWidget)],
                    ),
                  ),
                ),
              )
              : const SizedBox(),
    );
  }
}
