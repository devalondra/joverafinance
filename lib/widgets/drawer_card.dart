import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class DrawerCard extends StatelessWidget {
  const DrawerCard({
    super.key,
    required this.title,
    required this.leadingIconPath,
    required this.onTap,
    this.language,
    this.notification,
    required this.controller,
    this.color,
  });
  final Function() onTap;
  final String title;
  final String leadingIconPath;
  final bool? language;
  final bool? notification;
  final BottomNavigationBarController controller;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(leadingIconPath),
      title: MainText(text: title, color: color),
      onTap: onTap,
      trailing:
          language == true
              ? Obx(
                () => CupertinoSwitch(
                  value: controller.language.value,
                  onChanged: (value) {
                    controller.language.value = value;
                    controller.changeLanguage(value ? 'en_US' : 'ar_SA');
                  },
                ),
              )
              : notification == true
              ? Obx(
                () => CupertinoSwitch(
                  value: controller.notification.value,
                  onChanged: (value) {
                    controller.showNotificationsDialog(value);
                  },
                ),
              )
              : Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.grey,
                size: fullWidth * 0.04,
              ),
    );
  }
}
