import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class TrackingCard extends StatelessWidget {
  const TrackingCard({
    super.key,
    required this.iconPath,
    required this.subtitle,
    required this.title,
    required this.status,
    this.color,
  });
  final String iconPath;
  final String title;
  final String subtitle;
  final Color? color;
  final bool status;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(
                color != null
                    ? color!
                    : status
                    ? AppColors.primary
                    : AppColors.grey,
                BlendMode.srcIn,
              ),
            ),

            title == "Funded" || title == "Rejected"
                ? SizedBox(height: fullWidth * 0.05, width: fullWidth * 0.1)
                : SvgPicture.asset(
                  "assets/icons/dotted_line.svg",
                  colorFilter: ColorFilter.mode(
                    color != null
                        ? color!
                        : status
                        ? AppColors.primary
                        : AppColors.grey,
                    BlendMode.srcIn,
                  ),
                ),
            SizedBox(height: fullHeight * 0.01),
          ],
        ),
        SizedBox(width: fullWidth * 0.03),
        MainText(
          text: title,
          color:
              color == null
                  ? status
                      ? AppColors.primary
                      : AppColors.grey
                  : color!,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
        ).paddingOnly(top: fullHeight * 0.002),
      ],
    );
  }
}
