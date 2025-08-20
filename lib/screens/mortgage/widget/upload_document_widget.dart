import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/mortgage/widget/view_document_view.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class UploadDocumentWidget extends StatelessWidget {
  const UploadDocumentWidget({
    super.key,
    required this.onTap,

    required this.text,
   
    required this.filePath,
    required this.isPdf,
  });
  final Function() onTap;

  final bool isPdf;
  final String text;
  final String filePath;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/upload_icon.svg",

                    colorFilter:
                        filePath.isNotEmpty
                            ? ColorFilter.mode(AppColors.green, BlendMode.srcIn)
                            : null,
                  ),
                  SizedBox(width: fullWidth * 0.05),
                  MainText(text: text),
                ],
              ),

              filePath.isNotEmpty
                  ? InkWell(
                    onTap: () {
                      Get.to(
                        () => ViewDocumentView(
                          filePath: filePath,
                          isPdf: isPdf,
                          title: text,
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: fullWidth * 0.015,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.green,
                        borderRadius: BorderRadius.circular(fullWidth * 0.005),
                      ),
                      child: MainText(text: "View", fontSize: 14),
                    ),
                  )
                  : SizedBox(),

              // Row(
              //   children: [
              //     fileName,
              //     Visibility(
              //       visible: visibility,
              //       child: Icon(
              //         Icons.cancel,
              //         color: AppColors.lightGrey,
              //         size: fullWidth * 0.04,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),

          Divider(color: AppColors.grey),
        ],
      ),
    ).paddingOnly(bottom: fullHeight * 0.01);
  }
}
