import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/widgets/app_loading_controller.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';

import 'package:jovera_finance/widgets/loading.dart';

class Background extends StatelessWidget {
  final Widget child;
  final bool? safeAreaTop, safeAreaBottom, safeAreaRight, safeAreaLeft;
  final Color? safeAreaColor;
  final AppLoadingController? appLoadingController;

  const Background({
    super.key,
    required this.child,
    this.safeAreaTop,
    this.safeAreaBottom,
    this.safeAreaColor,
    this.appLoadingController,
    this.safeAreaRight,
    this.safeAreaLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {},
          //
          //   ) => appTools.unFocusKeyboard(context),
          child:
              Container(
                width: Get.width,
                height: Get.height,
                color: safeAreaColor ?? AppColors.backgroundColor,
                child: SafeArea(
                  top: safeAreaTop ?? true,
                  bottom: safeAreaBottom ?? false,
                  right: safeAreaRight ?? false,
                  left: safeAreaLeft ?? false,
                  child: child,
                ),
              ).marginZero,
        ),
        Loading(appLoading: appLoadingController ?? AppLoadingController()),
      ],
    );
  }
}
