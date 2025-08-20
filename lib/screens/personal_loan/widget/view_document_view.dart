import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';
import 'package:jovera_finance/widgets/document_view_widget.dart';

class ViewDocumentView extends StatelessWidget {
  const ViewDocumentView({
    super.key,
    required this.filePath,
    required this.isPdf,
    required this.title,
  });
  final String filePath;
  final bool isPdf;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      body: Column(
        children: [
          SizedBox(height: fullHeight * 0.05),
          CustomPageTitle(back: true, notification: false, title: title),
          SizedBox(height: fullHeight * 0.05),
          DocumentViewWidget(
            height: fullHeight * 0.6,
            filePath: filePath,
            isPdf: isPdf,
            hideEditButton: true,
            onPressed: () {},
          ),
        ],
      ).paddingSymmetric(
        horizontal: horizontalPagePadding * 1.2,
        vertical: verticalPagePadding,
      ),
    );
  }
}
