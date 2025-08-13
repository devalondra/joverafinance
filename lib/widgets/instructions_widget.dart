import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class InstructionsWidget extends StatelessWidget {
  const InstructionsWidget({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: fullWidth,
          height: fullHeight * 0.6,
          decoration: BoxDecoration(
            color: AppColors.black2,

            border: Border.all(
              width: 0.5,
              color: const Color.fromARGB(255, 84, 73, 51),
            ),
          ),
        ).paddingOnly(top: fullHeight * 0.067, right: fullWidth * 0.015),
        Container(
          width: fullWidth,
          height: fullHeight * 0.6,
          decoration: BoxDecoration(
            color: AppColors.black2,

            border: Border.all(
              width: 0.5,
              color: const Color.fromARGB(255, 84, 73, 51),
            ),
          ),
        ).paddingOnly(left: fullWidth * 0.015, top: fullHeight * 0.06),

        Column(
          children: [
            Center(child: Image.asset("assets/images/clip.png")),
            SizedBox(height: verticalPagePadding),
            Align(
              alignment: Alignment.centerLeft,
              child: MainText(
                text: "Important Notes:",
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: verticalPagePadding),
            child,
          ],
        ).paddingSymmetric(horizontal: horizontalPagePadding),
      ],
    );
  }
}
