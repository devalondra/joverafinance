import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';

class AppLoadingController {
  RxBool isLoading = false.obs;
  var loadingWidget = SpinKitCircle(color: AppColors.primaryLight, size: 40.0);

  void loading() {
    debugPrint("start loaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaading");
    isLoading.value = true;
  }

  void stop() {
    debugPrint("stop loaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaading");
    isLoading.value = false;
  }
}
