import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class DatePickerWidget {
  void showCupertinoDialog(selectedDate, onDateTimeChanged) {
    showCupertinoModalPopup<void>(
      context: Get.context!,
      builder:
          (BuildContext context) => Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),

            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),

            decoration: BoxDecoration(
              color: AppColors.darkGrey,
              borderRadius: BorderRadius.circular(fullWidth * 0.04),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Material(
                    color: AppColors.transparent,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: MainText(text: "Done"),
                    ),
                  ),
                ).paddingSymmetric(
                  horizontal: fullWidth * 0.08,
                  vertical: fullHeight * 0.01,
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    initialDateTime: selectedDate.add(const Duration(hours: 1)),
                    minimumDate: DateTime(1900, 01, 01),
                    maximumDate: DateTime(2035),
                    backgroundColor: AppColors.darkGrey,
                    mode: CupertinoDatePickerMode.date,
                    use24hFormat: true,
                    showDayOfWeek: true,
                    onDateTimeChanged: (date) => onDateTimeChanged(date),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  String getMonthName(int month) {
    switch (month) {
      case 1:
        return "January";

      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "";
    }
  }
}
