import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    List points = [
      {
        "text":
            "Welcome to Jovera Tourism – Your Trusted Travel Partner in the UAE."
                .tr,
        "heading": false,
      },
      {
        "text":
            "Jovera Tourism - L.L.C - O.P.C is a licensed and government-registered tourism company based in Abu Dhabi, United Arab Emirates. We specialize in providing a wide range of travel, tourism, and visa services to both residents and international visitors. As part of the Jovera Group, we are committed to delivering seamless, reliable, and innovative solutions for all your travel needs."
                .tr,
        "heading": false,
      },
      {"text": "What We Do".tr, "heading": true},
      {
        "text":
            "We offer professional and customer-centric services, including:"
                .tr,
        "heading": false,
      },
      {
        "text":
            "•	Visa Services: UAE tourist visas, transit visas, and visa extension services"
                .tr,
        "heading": false,
      },
      {
        "text":
            "•	Flight Bookings: Domestic and international ticketing with trusted airline partners"
                .tr,
        "heading": false,
      },
      {
        "text":
            "Holiday Packages: Customized tour packages for families, individuals, and corporate groups"
                .tr,
        "heading": false,
      },
      {
        "text":
            "•	Hotel Reservations: Affordable and luxury hotel bookings worldwide"
                .tr,
        "heading": false,
      },
      {
        "text":
            "•	Travel Insurance: Assistance in securing suitable coverage for your journeys"
                .tr,
        "heading": false,
      },
      {
        "text":
            "•	Tour Planning & Excursions: City tours, desert safaris, cultural trips, and more"
                .tr,

        "heading": false,
      },
      {"text": "Why Choose Us".tr, "heading": true},
      {
        "text":
            "• Licensed & Compliant: Registered with the Department of Economic Development, UAE"
                .tr,
        "heading": false,
      },
      {
        "text":
            "• Trusted by Thousands: Reliable services with a growing customer base across the UAE and abroad"
                .tr,
        "heading": false,
      },
      {
        "text":
            "• Expert Support: A dedicated team with deep expertise in the travel and visa industry"
                .tr,

        "heading": false,
      },
      {
        "text":
            "• Secure Payments: Encrypted and safe payment systems for peace of mind"
                .tr,
        "heading": false,
      },
      {
        "text":
            "• Fast Processing: Efficient documentation and visa handling with regular updates"
                .tr,
        "heading": false,
      },
      {"text": "Our Vision".tr, "heading": true},
      {
        "text":
            "To become a leading name in the travel and tourism industry in the UAE and the region by offering innovative, accessible, and affordable travel experiences."
                .tr,

        "heading": false,
      },
      {"text": "Our Mission".tr, "heading": true},
      {
        "text":
            "To provide high-quality travel solutions that exceed customer expectations while maintaining transparency, trust, and integrity in everything we do."
                .tr,
        "heading": false,
      },
      {"text": "Company Information".tr, "heading": true},
      {
        "text": "•	 Legal Name: JOVERA TOURISM - L.L.C - O.P.C ".tr,
        "heading": false,
      },
      {
        "text": "•	Trade Name (Arabic): جوفـــيـرا للسياحة - ذ.م.م - ش.ش.و ".tr,

        "heading": false,
      },
      {
        "text": "•	Corporate Tax Registration Number (TRN): 104362827800001".tr,
        "heading": false,
      },
      {"text": "•	Official Email: info@joveratourism.ae".tr, "heading": false},
      {"text": "•	Official Contact: +971 02 631 1977".tr, "heading": false},
      {
        "text":
            "•	Address: Al Nahyan, East 22_2, Jazeera Sports and Cultural Club Building, Abu Dhabi, UAE"
                .tr,

        "heading": false,
      },
      {"text": "•	Part of: Jovera Group".tr, "heading": false},
      {"text": "Contact Us".tr, "heading": true},
      {"text": "Head Office Address:".tr, "heading": false},
      {
        "text":
            "Al Nahyan, East 22_2, Jazeera Sports & Cultural Club Building, Abu Dhabi, UAE"
                .tr,
        "heading": false,
      },
      {"text": "Email: info@joveratourism.ae".tr, "heading": false},
      {"text": "Phone: +971 02 631 1977".tr, "heading": false},
      {"text": "Website: www.joveratourism.ae".tr, "heading": false},
    ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
      
        body: Column(
          children: [
            CustomPageTitle(
              notification: false,
              back: true,
              title: "About".tr,
            ).paddingOnly(bottom: fullHeight * 0.05),
            Expanded(
              child: ListView.builder(
                itemCount: points.length,
                itemBuilder:
                    (context, index) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.circle,
                          color:
                              points[index]["heading"] == true
                                  ? AppColors.grey
                                  : AppColors.backgroundColor,
                          size: fullWidth * 0.03,
                        ).paddingOnly(top: fullHeight * 0.005),
                        SizedBox(width: fullWidth * 0.02),
                        Expanded(
                   
                          child: MainText(
                            text: points[index]["text"],
                            textAlign: TextAlign.justify,
                            fontSize: 13.sp,
                            fontWeight:
                                points[index]["heading"] == true
                                    ? FontWeight.bold
                                    : FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: fullWidth * 0.04),
                      ],
                    ).paddingOnly(bottom: fullHeight * 0.01),
              ),
            ),
          ],
        ).paddingSymmetric(
          horizontal: horizontalPagePadding,
          vertical: verticalPagePadding,
        ),
      ),
    );
  }
}
