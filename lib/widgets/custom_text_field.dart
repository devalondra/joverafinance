import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextInputType keyboardType;
  final Widget? prefixIcon, suffixIcon;
  final Widget? prefix;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final bool? prefixIconConstraints;
  final String? Function(String?)? validator;
  final int? maxLines;
  final bool? readOnly;
  final int? maxLength;
  final EdgeInsetsGeometry? contentPadding;
  final bool? disable;
  final List<TextInputFormatter>? inputFormatters;
  final Color? bgColor;
  final bool? border;
  final Color? borderColor;
  final TextAlign? textAlignment;
  final Color? textColor;
  final bool? label;
  final double? borderRadius;
  final bool? alignLabelWithHint;
  final bool? isDense;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  const CustomTextField({
    super.key,
    this.isDense,
    required this.controller,
    this.hintText,
    this.validator,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines,
    this.borderRadius,
    this.bgColor,
    this.hintStyle,
    this.maxLength,
    this.contentPadding,
    this.disable,
    this.inputFormatters,
    this.border,
    this.prefix,
    this.prefixIconConstraints,
    this.borderColor,
    this.textAlignment,
    this.textColor,
    this.label,
    this.alignLabelWithHint,
    this.onSubmitted,
    this.textInputAction,
    this.focusNode,
    this.readOnly,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? errorMessage;
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return IgnorePointer(
      ignoring: widget.disable ?? false,

      child: TextFormField(
        readOnly: widget.readOnly ?? false,
        textInputAction: widget.textInputAction,
        inputFormatters: widget.inputFormatters,
        onFieldSubmitted: widget.onSubmitted,
        focusNode: widget.focusNode,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        cursorColor: AppColors.primary,
        scrollPadding: EdgeInsets.zero,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        textAlign:
            isRtl ? TextAlign.right : widget.textAlignment ?? TextAlign.left,
        onChanged: (val) {
          if (widget.validator != null) {
            errorMessage = widget.validator!(val);
          }
          if (widget.onChanged != null) {
            widget.onChanged!(val);
          }
          setState(() => () {});
        },
        style: Get.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w400,
          color: widget.textColor ?? AppColors.white,
        ),
        obscureText:
            widget.keyboardType == TextInputType.visiblePassword
                ? obscureText
                : false,
        decoration: InputDecoration(
          contentPadding: widget.contentPadding,
          fillColor: widget.bgColor,
          filled: widget.bgColor != null,
          label:
              widget.label != false
                  ? Text(
                    widget.hintText!,
                    style: TextStyle(color: AppColors.grey, fontSize: 14),
                  )
                  : null,
          hintStyle:
              widget.hintStyle ??
              Get.textTheme.bodyLarge?.copyWith(color: AppColors.lightText),
          //  hintText: widget.label == true ? null : widget.hintText?.tr,
          prefix: widget.prefix,
          prefixIcon: widget.prefixIcon,
          prefixIconConstraints:
              widget.prefixIconConstraints == true
                  ? BoxConstraints.expand(
                    width: fullWidth * 0.06,
                    height: fullHeight * 0.05,
                    //   Size.fromWidth(fullWidth * 0.01),
                  )
                  : null,
          suffixIcon: widget.suffixIcon,
          border: InputBorder.none,
          isDense: widget.isDense,
          hintText: widget.label == false ? widget.hintText : null,
          labelText: widget.label == true ? widget.hintText?.tr : null,
          labelStyle:
              widget.hintStyle ??
              Get.textTheme.bodyLarge?.copyWith(color: AppColors.darkGrey),
          alignLabelWithHint: widget.alignLabelWithHint ?? false,

          errorText: null,
          helperText: null,
          enabledBorder:
              widget.border ?? false
                  ? OutlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.borderColor ?? AppColors.white,
                    ),
                    borderRadius: BorderRadius.circular(
                      widget.borderRadius ?? fullWidth * 0.025,
                    ),
                  )
                  : UnderlineInputBorder(
                    borderSide: BorderSide(
                      color:
                          errorMessage == null
                              ? widget.borderColor ?? Color(0xFFD4D4D4)
                              : Colors.red,
                    ),
                  ),
          focusedBorder:
              widget.border ?? true
                  ? OutlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.borderColor ?? AppColors.grey,
                    ),
                    borderRadius: BorderRadius.circular(
                      widget.borderRadius ?? fullWidth * 0.025,
                    ),
                  )
                  : UnderlineInputBorder(
                    borderSide: BorderSide(
                      color:
                          errorMessage == null
                              ? AppColors.primaryLight
                              : Colors.red,
                    ),
                  ),
          errorBorder:
              widget.border ?? true
                  ? const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  )
                  : OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(0),
                  ),
          focusedErrorBorder:
              widget.border ?? true
                  ? const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  )
                  : OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(
                      widget.borderRadius ?? 0,
                    ),
                  ),
        ),
      ),
    );
  }
}
