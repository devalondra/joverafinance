import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/screens/main_drawer/view/edit_profile_view.dart';
import 'package:jovera_finance/screens/main_drawer/widget/profile_fields.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/utilities/extensions/widget_extensions.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';
import 'package:jovera_finance/widgets/background.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';

class MyProfileView extends ConsumerWidget {
  const MyProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(bottomNavigationBarControllerProvider.notifier);
    ref.watch(bottomNavigationBarControllerProvider);
    return Background(
      appLoadingController: controller.appLoadingController,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: fullHeight * 0.02),
                  CustomPageTitle(
                    back: true,
                    notification: false,
                    title: "Profile".tr,
                  ),
                  SizedBox(height: fullHeight * 0.03),
                  Center(
                    child: CircleAvatar(
                      backgroundColor: AppColors.backgroundColor,
                      radius: fullWidth * 0.2,
                      backgroundImage:
                          controller.profilePicturePath != ''
                              ? controller.profilePicturePath
                                      .startsWith('https')
                                  ? NetworkImage(
                                    controller.profilePicturePath,
                                  )
                                  : FileImage(
                                    File(controller.profilePicturePath),
                                  )
                              : null,

                      child:
                          controller.profilePicturePath == ''
                              ? SvgPicture.asset(
                                "assets/icons/profile_icon.svg",
                                fit: BoxFit.fill,
                              )
                              : null,
                    ),
                  ),

                  SizedBox(height: fullHeight * 0.04),
                  Profilefields(controller: controller),
                ],
              ),
            ),
            CustomButton(
              onPressed: () {
                AppNavigator.push(EditProfileView());
              },
              text: "Edit".tr,
            ).paddingOnly(bottom: fullHeight * 0.08),
          ],
        ).paddingSymmetric(
          horizontal: horizontalPagePadding,
          vertical: verticalPagePadding,
        ),
      ),
    );
  }
}
