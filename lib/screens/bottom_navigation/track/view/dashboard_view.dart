import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/bottom_navigation/track/controller/dashboard_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/track/widget/application_card.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/utilities/extensions/widget_extensions.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';
import 'package:jovera_finance/widgets/background.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(dashboardControllerProvider.notifier);
    ref.watch(dashboardControllerProvider);
    return SafeArea(
      child: Background(
        appLoadingController: controller.appLoadingController,
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomPageTitle(
                title: "Dashboard".tr,
                back: false,
                notification: false,
              ).paddingSymmetric(horizontal: horizontalPagePadding),
              SizedBox(height: fullHeight * 0.03),

              Expanded(
                child: RefreshIndicator.adaptive(
                  onRefresh: () async {
                    await controller.getMyApplications();
                  },
                  child:
                      controller.myVisaApplications.isEmpty
                          ? ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              SizedBox(height: fullHeight * 0.35),
                              Center(
                                child: MainText(
                                  text:
                                      "You don't have any\napplications yet."
                                          .tr,
                                  color: AppColors.lightGrey,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )
                          : ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: controller.myVisaApplications.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: horizontalPagePadding,
                                  vertical: verticalPagePadding / 2,
                                ),
                                child: ApplicationCard(
                                  controller: controller,
                                  index: index,
                                ),
                              );
                            },
                          ),
                ),
              ),
            ],
          ).paddingSymmetric(vertical: verticalPagePadding),
        ),
      ),
    );
  }
}
