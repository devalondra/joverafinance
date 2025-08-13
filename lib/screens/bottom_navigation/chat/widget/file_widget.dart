
import 'package:dotted_border/dotted_border.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/material.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';

class FileWidget extends StatelessWidget {
  const FileWidget({
    super.key,
    required this.filePath,
    required this.isPdf,
    required this.onPressed,
  });
  final bool isPdf;
  final String filePath;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: Radius.circular(fullWidth * 0.02),
        strokeWidth: 2,
        dashPattern: [4, 5],
        color: AppColors.darkGrey,
      ),
      child: Container(
        height: fullHeight * 0.2,
        width: fullWidth * 0.49,
        child:
            isPdf
                ?
                SfPdfViewer.network( filePath)
                : Image.network(filePath, fit: BoxFit.cover),
      ),
    );
  }
}
