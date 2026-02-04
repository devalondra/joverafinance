import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/main_drawer/widget/drawer_widget.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/controller/chat_controller.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class BottomnavigationBarView extends ConsumerWidget {
  const BottomnavigationBarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(bottomNavigationBarControllerProvider.notifier);
    ref.watch(bottomNavigationBarControllerProvider);
    ref.watch(authManagerProvider);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (controller.selectedIndex != 0) {
          controller.onItemTapped(0);
        } else {
          if (didPop) return;

          bool confirmExit =
              await showDialog<bool>(
                context: context,
                builder:
                    (_) => AlertDialog(
                      backgroundColor: AppColors.black2,
                      title: MainText(
                        text: "Exit App",
                        color: AppColors.primary,
                      ),
                      content: MainText(
                        text: "Are you sure you want to exit the app?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: MainText(text: "Cancel"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: MainText(
                            text: "Exit",
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
              ) ??
              false;
          if (confirmExit) {
            SystemNavigator.pop();
          }
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.backgroundColor,

          body: Center(
            child: controller.widgetOptions.elementAt(
              controller.selectedIndex,
            ),
          ),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.selectedIndex,
            backgroundColor: AppColors.black2,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            useLegacyColorScheme: true,
            unselectedItemColor: AppColors.textGrey,
            selectedItemColor: AppColors.primary,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  
                  "assets/icons/home_icon.svg",
                  colorFilter: ColorFilter.mode(
                    controller.selectedIndex == 0
                        ? AppColors.primary
                        : AppColors.textGrey,
                    BlendMode.srcIn,
                  ),
                ),
                label: "Home".tr,
                backgroundColor: AppColors.black2,
              ),
              BottomNavigationBarItem(
                backgroundColor: AppColors.black2,
                icon: SvgPicture.asset(
                  "assets/icons/loan_icon.svg",
                  colorFilter: ColorFilter.mode(
                    controller.selectedIndex == 1
                        ? AppColors.primary
                        : AppColors.textGrey,
                    BlendMode.srcIn,
                  ),
                ),
                label: "Services".tr,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icons/calculator_icon.svg",
                  colorFilter: ColorFilter.mode(
                    controller.selectedIndex == 2
                        ? AppColors.primary
                        : AppColors.textGrey,
                    BlendMode.srcIn,
                  ),
                ),
                label: "Calculator".tr,
                backgroundColor: AppColors.black2,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icons/chat_icon.svg",
                  colorFilter: ColorFilter.mode(
                    controller.selectedIndex == 3
                        ? AppColors.primary
                        : AppColors.textGrey,
                    BlendMode.srcIn,
                  ),
                ),
                label: "Chat".tr,
                backgroundColor: AppColors.black2,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icons/tracking_icon.svg",
                  colorFilter: ColorFilter.mode(
                    controller.selectedIndex == 4
                        ? AppColors.primary
                        : AppColors.textGrey,
                    BlendMode.srcIn,
                  ),
                ),
                label: "Track".tr,

                backgroundColor: AppColors.black2,
              ),
            ],
            onTap: (index) {
              controller.onItemTapped(index);

              if (index == 3) {
                Future.delayed(const Duration(milliseconds: 300), () {
                  ref.read(chatControllerProvider.notifier).scrollToBottom();
                });
              }
            },
          ),

          endDrawer: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            child: Drawer(
              backgroundColor: AppColors.black2,

              child: DrawerWidget(),
            ),
          ),
        ),
    );
  }
}
