import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/bottom_navigation/bottom/controller/bottom_navigation_bar_controller.dart';
import 'package:jovera_finance/screens/business_loan/widget/background_decoration.dart';
import 'package:jovera_finance/screens/main_drawer/widget/help_row_widget.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/utilities/extensions/widget_extensions.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';
import 'package:jovera_finance/widgets/custom_text_field.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class ContactUsView extends ConsumerWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(bottomNavigationBarControllerProvider.notifier);
    ref.watch(bottomNavigationBarControllerProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,

        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomPageTitle(
                notification: false,
                back: true,
                title: "Contact us".tr,
              ).paddingOnly(bottom: fullHeight * 0.01),
              SizedBox(
                height: fullHeight * 0.13,

                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: controller.contactList.length,
                  itemBuilder:
                      (context, index) => Center(
                        child: InkWell(
                          onTap: () {
                            controller.selectedContactIndex = index;
                          },
                          child: Container(
                            width: fullHeight * 0.12,
                            padding: EdgeInsets.all(fullWidth * 0.02),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                fullWidth * 0.02,
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors:
                                    controller.selectedContactIndex == index
                                        ? [
                                          const Color.fromARGB(
                                            255,
                                            118,
                                            91,
                                            34,
                                          ),
                                          AppColors.primary,
                                        ]
                                        : [
                                          AppColors.black2,
                                          AppColors.black2,
                                        ],
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  controller.contactList[index].icon,
                                ),
                                SizedBox(height: fullHeight * 0.005),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MainText(
                                      text:
                                          controller.contactList[index].title,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ).paddingAll(fullWidth * 0.01),
                      ),
                ),
              ),
              controller.selectedContactIndex == 2
                  ? Container(
                    padding: EdgeInsets.all(fullWidth * 0.05),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(fullWidth * 0.04),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          const Color.fromARGB(255, 118, 91, 34),
                          AppColors.primary,
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MainText(
                          text: "REQUEST CALLBACK",
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),

                        MainText(
                          text: "Full Name",
                        ).paddingOnly(top: fullHeight * 0.015),
                        CustomTextField(
                          controller: controller.callBackFullNameController,
                          label: false,
                          bgColor: AppColors.yellow,
                          borderColor: AppColors.yellow,
                        ),
                        MainText(
                          text: "Phone",
                        ).paddingOnly(top: fullHeight * 0.015),
                        CustomTextField(
                          controller: controller.callBackPhoneController,
                          label: false,
                          contentPadding: EdgeInsets.only(
                            top: fullHeight * 0.015,
                          ),
                          keyboardType: TextInputType.phone,
                          bgColor: AppColors.yellow,
                          borderColor: AppColors.yellow,
                          prefixIcon: SizedBox(
                            //  width: fullWidth * 0.04,
                            child: InkWell(
                              onTap: () {
                                showCountryPicker(
                                  useSafeArea: true,
                                  showPhoneCode: true,
                                  countryListTheme: CountryListThemeData(
                                    backgroundColor: AppColors.black2,
                                    textStyle: TextStyle(
                                      color: AppColors.lightText,
                                    ),
                                  ),
                                  context: context,
                                  onSelect: (country) {
                                    controller.callbackCountryCode =
                                        country.phoneCode;
                                  },
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MainText(
                                    text:
                                        controller.callbackCountryCode
                                                .startsWith("+")
                                            ? controller.callbackCountryCode
                                            : "+${controller.callbackCountryCode}",

                                    fontSize: 12.spMin,
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: AppColors.lightText,
                                  ),
                                ],
                              ),
                            ),
                          ).paddingSymmetric(horizontal: fullWidth * 0.02),
                        ),
                        MainText(
                          text: "Email",
                        ).paddingOnly(top: fullHeight * 0.015),
                        CustomTextField(
                          controller: controller.callBackEmailController,
                          label: false,
                          bgColor: AppColors.yellow,
                          borderColor: AppColors.yellow,
                        ),
                        MainText(
                          text: "Loan Type",
                        ).paddingOnly(top: fullHeight * 0.015),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.yellow,
                            borderRadius: BorderRadius.circular(
                              fullWidth * 0.01,
                            ),
                            border: Border.all(color: AppColors.yellow),
                          ),
                          child: DropdownButton<String>(
                            value: controller.selectedLoanType,
                            isExpanded: true,
                            dropdownColor: AppColors.black2,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.white,
                            ),
                            underline: SizedBox(),
                            items:
                                [
                                  'Business Loan',
                                  'Mortgage Loan',
                                  'Personal Loan',
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: MainText(text: value),
                                  );
                                }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                controller.selectedLoanType = newValue;
                              }
                            },
                          ),
                        ),
                        MainText(
                          text: "Message",
                        ).paddingOnly(top: fullHeight * 0.015),
                        CustomTextField(
                          controller: controller.callBackMessageController,
                          label: false,

                          bgColor: AppColors.yellow,
                          maxLines: 3,
                          borderColor: AppColors.yellow,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                controller.requestCallBack();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: fullWidth * 0.02,
                                  vertical: fullWidth * 0.01,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    fullWidth * 0.015,
                                  ),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      const Color.fromARGB(255, 111, 81, 17),
                                      AppColors.primary,
                                    ],
                                  ),
                                ),
                                child: MainText(text: "Submit"),
                              ).paddingOnly(top: fullHeight * 0.01),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                  : controller.selectedContactIndex == 1
                  ? Column(
                    children: [
                      BackgroundDecoration(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/address_icon.svg",
                              width: fullWidth * 0.05,
                              height: fullWidth * 0.05,
                            ),
                            SizedBox(width: fullWidth * 0.05),
                            Expanded(
                              child: MainText(
                                text:
                                    "Al Jazira Club Office Tower A 8th floor, Abu Dhabi, United Arab Emirates",
                              ),
                            ),
                          ],
                        ).paddingAll(fullWidth * 0.01),
                      ),
                      SizedBox(height: fullWidth * 0.05),
                      BackgroundDecoration(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/calender_icon.svg",
                              width: fullWidth * 0.05,
                              height: fullWidth * 0.05,
                            ),
                            SizedBox(width: fullWidth * 0.05),
                            Expanded(
                              child: MainText(
                                text:
                                    "${"Monday - Saturday".tr}\n${"10 : 00 AM - 6:30 PM".tr}",
                              ),
                            ),
                          ],
                        ).paddingAll(fullWidth * 0.01),
                      ),
                    ],
                  )
                  : BackgroundDecoration(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            MainText(
                              text: "HELP & SUPPORT",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ).paddingAll(fullWidth * 0.015),
                        HelpRowWidget(
                          icon: "assets/icons/mail_icon.svg",
                          title: "info@joveratourism.ae",
                        ),
                        HelpRowWidget(
                          icon: "assets/icons/call_icon.svg",
                          title: "456789765",
                        ),
                        HelpRowWidget(
                          icon: "assets/icons/whatsapp_icon.svg",
                          title: "+97156478687",
                        ),
                      ],
                    ),
                  ),
            ],
          ).paddingSymmetric(
            horizontal: horizontalPagePadding,
            vertical: verticalPagePadding,
          ),
        ),
      ),
    );
  }
}
