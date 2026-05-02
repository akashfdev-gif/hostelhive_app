import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hostel_hive/core/app_export.dart';

class CustomTextFormFieldV2 extends StatelessWidget {
  final FocusNode? focusNode;
  final TextInputType? keyboard;
  final TextEditingController? controller;
  final int? maxLength;
  final TextCapitalization? capitalization;
  final AutovalidateMode? validateMode;
  final String? Function(String?)? validator;
  final void Function(String)? onChange;
  final String? hintText;
  final String? labelText;
  final Widget? label;
  final String? initialValue;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatter;
  final void Function()? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? readOnly;
  final bool? obscureText;
  final int? maxLines;
  final int? minLines;
  final String? prefixText;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? prefixTextStyle;
  final EdgeInsets? prefixPadding;
  final BoxConstraints? prefixBoxConstraints;
  final Color? fillColor;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? disabledBorder;
  final bool labelLowercase;

  const CustomTextFormFieldV2(
      {super.key,
      this.labelLowercase = false,
      this.focusNode,
      this.prefixIcon,
      this.keyboard,
      this.controller,
      this.maxLength,
      this.capitalization,
      this.validateMode,
      this.validator,
      this.onChange,
      this.hintText,
      this.labelText,
      this.label,
      this.initialValue,
      this.inputFormatter,
      this.enabled,
      this.onTap,
      this.suffixIcon,
      this.readOnly,
      this.obscureText,
      this.maxLines,
      this.minLines,
      this.prefixText,
      this.textStyle,
      this.hintTextStyle,
      this.prefixTextStyle,
      // this.prefixIcon,
      this.prefixPadding,
      this.prefixBoxConstraints,
      this.fillColor,
      this.floatingLabelBehavior,
      this.border,
      this.enabledBorder,
      this.focusedBorder,
      this.disabledBorder});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (labelText != null)
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Text(labelLowercase ? labelText! : labelText!.toUpperCase(),
                style: CustomTextStyle.textXsMedium
                    .copyWith(color: const Color(0xFF646464))),
          ),
        TextFormField(
          onTap: onTap,
          obscureText: obscureText ?? false,
          focusNode: focusNode,
          readOnly: readOnly ?? false,
          onTapOutside: (event) => focusNode != null
              ? focusNode?.unfocus()
              : FocusScope.of(context).unfocus(),
          keyboardType: keyboard,
          controller: controller,
          initialValue: initialValue,
          maxLength: maxLength,
          inputFormatters: inputFormatter,
          style: textStyle ??
              CustomTextStyle.textXsRegular.copyWith(color: appTheme.black900),
          buildCounter: (context,
                  {required currentLength,
                  required isFocused,
                  required maxLength}) =>
              const SizedBox(),
          textCapitalization: capitalization ?? TextCapitalization.none,
          autovalidateMode: validateMode,
          validator: validator,
          onChanged: onChange,
          enabled: enabled,
          maxLines: maxLines,
          minLines: minLines,
          decoration: CustomTextFormFieldV2.customInputDecoration(
              hintText: hintText,
              hintTextStyle: hintTextStyle,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              prefixText: prefixText,
              prefixPadding: prefixPadding,
              prefixBoxConstraints: prefixBoxConstraints,
              fillColor: fillColor,
              label: label,
              floatingLabelBehavior: floatingLabelBehavior,
              border: border,
              enabledBorder: enabledBorder,
              focusedBorder: focusedBorder,
              disabledBorder: disabledBorder),
        ),
      ],
    );
  }

  static InputDecoration customInputDecoration(
      {String? hintText,
      Widget? suffixIcon,
      String? prefixText,
      TextStyle? prefixTextStyle,
      EdgeInsets? prefixPadding,
      BoxConstraints? prefixBoxConstraints,
      TextStyle? hintTextStyle,
      Widget? prefixIcon,
      Color? fillColor,
      Widget? label,
      FloatingLabelBehavior? floatingLabelBehavior,
      InputBorder? border,
      InputBorder? enabledBorder,
      InputBorder? focusedBorder,
      InputBorder? disabledBorder}) {
    return InputDecoration(
      label: label,
      floatingLabelBehavior: floatingLabelBehavior,
      suffixIcon: suffixIcon,
      isDense: true,
      hintText: hintText,
      border: border,
      prefixIcon: prefixText != null
          ? Padding(
              padding: prefixPadding ??
                  EdgeInsets.only(
                      left: 10.w, right: 0.w, top: 10.h, bottom: 8.h),
              child: FittedBox(
                child: Text(prefixText,
                    style: prefixTextStyle ??
                        CustomTextStyle.textBaseRegular.copyWith(
                            color: appTheme.black800, fontFamily: 'Roboto')),
              ),
            )
          : prefixIcon != null
              ? Padding(
                  padding: prefixPadding ?? EdgeInsets.zero,
                  child: prefixIcon,
                )
              : null,
      prefixIconConstraints: prefixBoxConstraints ??
          const BoxConstraints(minWidth: 0, minHeight: 0),
      errorStyle: CustomTextStyle.textBaseRegular,
      fillColor: fillColor ?? appTheme.otherWhite,
      errorMaxLines: 4,
      hintStyle: hintTextStyle ??
          CustomTextStyle.textXsRegular.copyWith(color: appTheme.otherHintText),
      filled: true,
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10.w),
      enabledBorder: enabledBorder ?? CustomTextFormFieldV2._enabledBorder(),
      focusedBorder: focusedBorder ?? CustomTextFormFieldV2._focusedBorder(),
      errorBorder: CustomTextFormFieldV2._errorBorder(),
      focusedErrorBorder: CustomTextFormFieldV2._focusedErrorBorder(),
      disabledBorder: disabledBorder ?? CustomTextFormFieldV2._disabledBorder(),
    );
  }

  // Custom border style for text form field
  static _enabledBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: appTheme.otherBorder, width: 1),
      borderRadius: BorderRadius.circular(8.h),
    );
  }

  static _focusedBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: appTheme.blue100, width: 1),
      borderRadius: BorderRadius.circular(8.h),
    );
  }

  static _errorBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: appTheme.red800, width: 1),
      borderRadius: BorderRadius.circular(8.h),
    );
  }

  static _focusedErrorBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: appTheme.red800, width: 1),
      borderRadius: BorderRadius.circular(8.h),
    );
  }

  static _disabledBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: appTheme.otherBorder, width: 1),
      borderRadius: BorderRadius.circular(8),
    );
  }
}
