import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class TrackingDetailsRow extends StatelessWidget {
  const TrackingDetailsRow({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MainText(text: title.tr, fontSize: 14.spMin),

        MainText(text: " : $value", fontSize: 14.spMin),
      ],
    ).paddingOnly(bottom: fullHeight * 0.01);
  }
}
