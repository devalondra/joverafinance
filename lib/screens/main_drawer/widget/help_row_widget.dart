import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class HelpRowWidget extends StatelessWidget {
  const HelpRowWidget({super.key, required this.icon, required this.title});
  final String icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          width: fullWidth * 0.05,
          height: fullWidth * 0.05,
        ),
        SizedBox(width: fullWidth * 0.03),
        MainText(text: title),
      ],
    ).paddingAll(fullWidth * 0.015);
  }
}
