import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_validators.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';

class CustomDropdown extends StatelessWidget {
  CustomDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.hint,
    required this.onChanged,
    required this.labelText,
  });

  String labelText;
  Function(dynamic) onChanged;
  List<DropdownMenuItem<dynamic>> items;
  var value;
  Widget? hint;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: fullWidth * 0.05, top: fullHeight * 0.015),
      decoration: BoxDecoration(
        color: AppColors.black2,
        borderRadius: BorderRadius.circular(fullWidth * 0.01),
      ),
      child: Center(
        child: DropdownButtonFormField(
          isExpanded: true,
          value: value,

          validator: (value) {
            return AppValidators().textValidation(value);
          },
          hint: hint,
          icon: Icon(
            Icons.arrow_drop_down_outlined,
            color: AppColors.grey,
          ).paddingOnly(right: fullWidth * 0.02, bottom: fullHeight * 0.02),
          decoration: InputDecoration(
            alignLabelWithHint: true,
            //  labelText: labelText,
            labelStyle: TextStyle(color: AppColors.lightGrey, fontSize: 14),
            isDense: true,
            contentPadding: EdgeInsets.only(bottom: fullHeight * 0.02),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.backgroundColor,
                width: 0.4,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.lightGrey),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),

          items: items,
          dropdownColor: AppColors.black2,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
