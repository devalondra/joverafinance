import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class UploadDocumentWidget extends StatelessWidget {
  const UploadDocumentWidget({
    super.key,
    required this.onTap,
    required this.fileName,
    required this.text,
    required this.visibility,
  });
  final Function() onTap;
  final Widget fileName;
  final bool visibility;
  final String text;
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

            children: [
              SvgPicture.asset("assets/icons/upload_icon.svg"),
              SizedBox(width: fullWidth * 0.05),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainText(text: text),
                  Row(
                    children: [
                      fileName,
                      Visibility(
                        visible: visibility,
                        child: Icon(
                          Icons.cancel,
                          color: AppColors.lightGrey,
                          size: fullWidth * 0.04,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          Divider(color: AppColors.grey),
        ],
      ),
    ).paddingOnly(bottom: fullHeight * 0.01);
  }
}
