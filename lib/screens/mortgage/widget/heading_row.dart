import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class HeadingRow extends StatelessWidget {
  const HeadingRow({
    super.key,
    required this.heading,
    required this.value,
    this.inputController,
    this.focusNode,
    this.onSubmitted,
    this.onEditingComplete,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
    this.prefixText,
    this.suffixText,
    this.leadingText,
    this.trailingText,
  });
  final String heading;
  final String value;
  final TextEditingController? inputController;
  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  final String? suffixText;
  final String? leadingText;
  final String? trailingText;
  @override
  Widget build(BuildContext context) {
    final bool editable = inputController != null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: MainText(text: heading, fontSize: 13)),
        if (editable)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leadingText != null) ...[
                MainText(text: leadingText!, fontSize: 12),
                const SizedBox(width: 6),
              ],
              SizedBox(
                width: fullWidth * 0.3,
                child: TextField(
                  controller: inputController,
                  focusNode: focusNode,
                  keyboardType: keyboardType ?? TextInputType.number,
                  inputFormatters: inputFormatters,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 4),
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    prefixText: prefixText,
                    suffixText: suffixText,
                    prefixStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 10.spMin,
                    ),
                    suffixStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 10.spMin,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  onSubmitted: onSubmitted,
                  onEditingComplete: onEditingComplete,
                  onChanged: onChanged,
                ),
              ),
              if (trailingText != null) ...[
                const SizedBox(width: 6),
                MainText(text: trailingText!, fontSize: 12),
              ],
            ],
          )
        else
          MainText(text: value, fontWeight: FontWeight.w500),
      ],
    );
  }
}
