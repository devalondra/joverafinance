import 'package:flutter/material.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class HeadingRow extends StatelessWidget {
  const HeadingRow({super.key, required this.heading, required this.value});
  final String heading;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MainText(text: heading, fontSize: 13),
        MainText(text: value, fontWeight: FontWeight.w500),
      ],
    );
  }
}
