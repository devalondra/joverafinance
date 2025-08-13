import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class DocumentPicker {
  void documentPickerWidget(
    BuildContext context,
    Function() pickImage,
    Function() pickPdf,
    Function() pickfromCamera,
  ) {
    showModalBottomSheet(
      backgroundColor: AppColors.black2,
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt, color: AppColors.primary),
                title: MainText(text: 'Camera'.tr),
                onTap: pickfromCamera,
              ),
              ListTile(
                leading: const Icon(Icons.photo, color: AppColors.primary),
                title: MainText(text: 'Gallery'.tr),
                onTap: pickImage,
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: AppColors.primary,
                ),
                title: MainText(text: 'Files'.tr),
                onTap: pickPdf,
              ),
            ],
          ),
        );
      },
    );
  }
}
