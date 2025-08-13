import 'dart:io';

import 'package:dotted_border/dotted_border.dart';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';

class FilePreview extends StatelessWidget {
  const FilePreview({
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
      child: Stack(
        children: [
          Container(
            height: fullHeight * 0.2,
            width: fullWidth * 0.49,
            child:
                isPdf
                    ? PDFView(filePath: filePath)
                    : Image.file(File(filePath), fit: BoxFit.cover),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.cancel, color: AppColors.primary),
              onPressed: onPressed,
            ),
          ),
        ],
      ),
    );
  }
}
