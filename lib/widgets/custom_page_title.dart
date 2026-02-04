import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/main_drawer/notification/controller/notification_controller.dart';
import 'package:jovera_finance/screens/main_drawer/notification/view/notification_view.dart';

import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';
import 'package:jovera_finance/widgets/main_text.dart';
import 'package:flutter/material.dart';

class CustomPageTitle extends ConsumerWidget {
  final String title;
  final Color? color;
  final bool back;
  final IconData? iconData;
  final Function()? onTapBack;
  final Widget? suffix;
  final bool notification;
  const CustomPageTitle({
    super.key,
    required this.back,
    required this.notification,
    required this.title,
    this.iconData,
    this.suffix,
    this.onTapBack,
    this.color,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationController =
        ref.read(notificationControllerProvider.notifier);
    ref.watch(notificationControllerProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        back
            ? InkWell(
              onTap: () {
                Navigator.of(context).maybePop();
              },
              child: Icon(Icons.arrow_back_ios, color: AppColors.white),
            )
            : SizedBox(),
        MainText(text: title.tr, fontSize: 18.sp, fontWeight: FontWeight.w500),
        suffix != null
            ? suffix!
            : notification
            ? InkWell(
              onTap: () {
                AppNavigator.push(NotificationView());
              },
              child:
                  notificationController.hasUnreadNotifications
                      ? SvgPicture.asset(
                        "assets/icons/unread_notification.svg",
                      )
                      : SvgPicture.asset(
                        "assets/icons/notification_icon.svg",
                      ),
            )
            : SizedBox(),
      ],
    );
  }
}
