import 'package:flutter/material.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class CustomButton extends StatelessWidget {
  final Color? color;
  final Function() onPressed;
  final double? width;
  final String text;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? borderRadius;
  final Color? textColor;
  final double? space;
  final Widget? icon;
  final WidgetStateProperty<Color>? backgroundColor;
  final Color? borderColor;
  const CustomButton({
    super.key,
    this.color,
    required this.onPressed,
    this.width,
    required this.text,
    this.textColor,
    this.height,
    this.icon,
    this.borderRadius,
    this.fontSize,
    this.fontWeight,
    this.backgroundColor,
    this.borderColor,
    this.space,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? fullHeight * 0.055,
      width: width ?? fullWidth,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              backgroundColor ??
              WidgetStateProperty.all(color ?? AppColors.primary),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                borderRadius ?? fullWidth * 0.02,
              ),
              side: BorderSide(color: borderColor ?? Colors.transparent),
            ),
          ),
        ),
        onPressed: onPressed,
        child:
            icon == null
                ? MainText(
                  text: text,
                  color: Colors.white,
                  fontSize: fontSize ?? 14,
                  fontWeight: fontWeight ?? FontWeight.w500,
                  letterSpacing: 0.8,
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon!,
                    SizedBox(width: space ?? fullWidth * 0.05),
                    MainText(
                      text: text,
                      color: Colors.white,
                      fontSize: fontSize ?? 14,
                      fontWeight: fontWeight ?? FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ],
                ),
      ),
    );
  }
}
