// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
// import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/profile_controller.dart';
// import 'package:jovera_finance/screens/bottom_navigation/bottom/drawer/my_profile_view.dart';
// import 'package:jovera_finance/screens/bottom_navigation/bottom/drawer/settings_view.dart';
// import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
// import 'package:jovera_finance/utilities/constants/app_colors.dart';
// import 'package:jovera_finance/utilities/constants/app_values.dart';
// import 'package:jovera_finance/widgets/background.dart';
// import 'package:jovera_finance/widgets/drawer_card.dart';
// import 'package:jovera_finance/widgets/main_text.dart';

// import 'package:url_launcher/url_launcher.dart';

// class ProfileView extends GetView<ProfileController> {
//   const ProfileView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Background(
//       appLoadingController: controller.appLoadingController,
//       child: Scaffold(
//         backgroundColor: AppColors.backgroundColor,

//         body: Column(
//           children: [
//             Expanded(
//               child: ListView(
//                 children: [
//                   Obx(
//                     () => Row(
//                       children: [
//                         Container(
//                           height: fullWidth * 0.17,
//                           width: fullWidth * 0.17,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(color: AppColors.darkGrey),
//                             image:
//                                 controller.authManager.appUser.value.picture !=
//                                             null &&
//                                         controller
//                                                 .authManager
//                                                 .appUser
//                                                 .value
//                                                 .picture !=
//                                             ""
//                                     ? DecorationImage(
//                                       image: NetworkImage(
//                                         controller
//                                             .authManager
//                                             .appUser
//                                             .value
//                                             .picture!,
//                                       ),
//                                       //AssetImage("assets/images/profile_image.jpg"),
//                                       fit: BoxFit.cover,
//                                     )
//                                     : DecorationImage(
//                                       image: AssetImage(
//                                         "assets/images/jovera_tourism_icon.png",
//                                       ),
//                                       fit: BoxFit.cover,
//                                     ),
//                           ),
//                         ),
//                         SizedBox(width: fullWidth * 0.03),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             controller.authManager.isLogged.value
//                                 ? Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         MainText(text: 'Welcome Back'.tr),
//                                         SizedBox(width: fullWidth * 0.02),
//                                         Icon(
//                                           Icons.waving_hand,
//                                           color: AppColors.primary,
//                                         ),
//                                       ],
//                                     ),
//                                     MainText(
//                                       text:
//                                           controller
//                                                       .authManager
//                                                       .appUser
//                                                       .value
//                                                       .name ==
//                                                   null
//                                               ? ""
//                                               : controller
//                                                   .authManager
//                                                   .appUser
//                                                   .value
//                                                   .name!,

//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ],
//                                 )
//                                 : Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     MainText(text: 'Travel Simplified'.tr),
//                                     SizedBox(width: fullWidth * 0.02),
//                                     Icon(
//                                       Icons.waving_hand,
//                                       color: AppColors.primary,
//                                     ),
//                                   ],
//                                 ),
//                           ],
//                         ),
//                       ],
//                     ).paddingSymmetric(
//                       vertical: verticalPagePadding * 1.5,
//                       horizontal: horizontalPagePadding,
//                     ),
//                   ),
//                   SizedBox(height: fullHeight * 0.02),
//                   Obx(
//                     () =>
//                         controller.authManager.isLogged.value
//                             ? Column(
//                               children: [
//                                 DrawerCard(
//                                   title: "Profile",
//                                   controller: controller,
//                                   onTap: () {
//                                     Get.to(() => MyProfileView());
//                                   },
//                                   leadingIconPath:
//                                       "assets/icons/edit_profile_icon.svg",
//                                 ),
//                                 Divider(color: AppColors.darkGrey),
//                               ],
//                             ).paddingSymmetric(horizontal: fullWidth * 0.02)
//                             : SizedBox(),
//                   ),

//                   DrawerCard(
//                     title: "Settings",
//                     controller: controller,
//                     onTap: () {
//                       Get.to(() => SettingsView(controller: controller));
//                     },
//                     leadingIconPath: "assets/icons/settings_icon.svg",
//                   ),
//                   Divider(color: AppColors.darkGrey),

//                   DrawerCard(
//                     title: "About".tr,
//                     controller: controller,
//                     onTap: () {
//                       Get.to(() => AboutView());
//                     },
//                     leadingIconPath: "assets/icons/about_icon.svg",
//                   ).paddingSymmetric(horizontal: fullWidth * 0.02),
//                   Divider(color: AppColors.darkGrey),
//                   DrawerCard(
//                     title: "Privacy Policy".tr,
//                     controller: controller,
//                     onTap: () async {
//                       await launchUrl(
//                         Uri.parse(
//                           "https://joveratourism.ae/components/privacyPolicy",
//                         ),
//                       ).onError((error, stackTrace) {
//                         appTools.showErrorSnackBar(
//                           'Something went wrong. Please check your connection.',
//                         );
//                         throw Exception();
//                       });
//                     },
//                     leadingIconPath: "assets/icons/privacy_icon.svg",
//                   ).paddingSymmetric(horizontal: fullWidth * 0.02),
//                   Divider(color: AppColors.darkGrey),
//                   DrawerCard(
//                     title: "Terms and Conditions".tr,
//                     controller: controller,
//                     onTap: () async {
//                       await launchUrl(
//                         Uri.parse(
//                           "https://joveratourism.ae/components/termsConditions",
//                         ),
//                       ).onError((error, stackTrace) {
//                         appTools.showErrorSnackBar(
//                           'Something went wrong. Please check your connection.',
//                         );
//                         throw Exception();
//                       });
//                     },
//                     leadingIconPath:
//                         "assets/icons/terms_and_conditions_icon.svg",
//                   ).paddingSymmetric(horizontal: fullWidth * 0.02),
//                   Divider(color: AppColors.darkGrey),
//                 ],
//               ),
//             ),
//             controller.authManager.isLogged.value
//                 ? Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SvgPicture.asset(
//                       "assets/icons/logout_icon.svg",
//                       colorFilter: ColorFilter.mode(
//                         AppColors.primary,
//                         BlendMode.srcIn,
//                       ),
//                     ),
//                     SizedBox(width: fullWidth * 0.02),
//                     InkWell(
//                       onTap: () {
//                         controller.authManager.logOut();
//                       },
//                       child: MainText(
//                         text: "Logout".tr,
//                         color: AppColors.primary,
//                       ),
//                     ),
//                   ],
//                 )
//                 : Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SvgPicture.asset(
//                       "assets/icons/logout_icon.svg",
//                       colorFilter: ColorFilter.mode(
//                         AppColors.primary,
//                         BlendMode.srcIn,
//                       ),
//                     ),
//                     SizedBox(width: fullWidth * 0.02),
//                     InkWell(
//                       onTap: () {
//                         BottomNavigationBarController cont = Get.find();
//                         cont.selectedIndex.value = 2;
//                       },
//                       child: MainText(
//                         text: "Sign In".tr,
//                         color: AppColors.primary,
//                       ),
//                     ),
//                   ],
//                 ),
//           ],
//         ).paddingSymmetric(vertical: verticalPagePadding * 1.5),
//       ),
//     );
//   }
// }
