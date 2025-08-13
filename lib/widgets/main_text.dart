import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MainText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final double? height;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final double? letterSpacing;
  final bool? softWrap;
  const MainText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.height,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.softWrap,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      softWrap: softWrap,
      style: Get.textTheme.bodyLarge?.copyWith(
        letterSpacing: letterSpacing ?? 0,
        color: color ?? AppColors.white,
        fontSize: fontSize ?? 16.spMin,
        fontWeight: fontWeight ?? FontWeight.w400,
        height: height,

        fontFamily: 'Poppins',
        decoration: decoration,
        decorationColor: color,
      ),
    );
  }
}
