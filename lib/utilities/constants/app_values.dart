import 'package:flutter/services.dart';
import 'package:get/get.dart';

double fullWidth = Get.width;
double fullHeight = Get.height;
double verticalPagePadding = fullHeight * 0.02;
double horizontalPagePadding = fullWidth * 0.05;
double customHorizontalSpace = Get.width * 0.04;
List<TextInputFormatter>? phoneInputFormatters= [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(15),
  ];