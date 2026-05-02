import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';

/// A custom elevated button widget that wraps around the [ElevatedButton] widget.
///
/// This widget allows you to create a button with custom styles and text.
///
/// The [CustomElevatedButton] requires an [onPressed] callback and a [text] string.
/// Optionally, you can provide a [child] widget to replace the default text widget.
///
/// Example usage:
///
/// ```dart
/// CustomElevatedButton(
///   onPressed: () {
///     // Handle button press
///   },
///   text: 'Click Me',
/// )
/// ```
///
/// If a [child] widget is provided, it will be used instead of the default text widget.
///
/// The button style is defined by [CustomButtonStyle.primaryButtonTheme].
/// The text style is defined by [CustomTextStyle.textBaseMedium] with a color of [appTheme.otherWhite].
///
/// See also:
///
///  * [ElevatedButton], which is the base widget being wrapped.
class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final ButtonStyle? buttonStyle;
  final bool loading;
  final MainAxisAlignment? alignment;
  final TextStyle? textStyle;

  final IconData? buttonIcon;
  final Widget? leftIcon;
  final Color? textColor;
  const CustomElevatedButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.buttonStyle,
      this.loading = false,
      this.buttonIcon,
      this.leftIcon,
      this.alignment,
      this.textStyle,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: buttonStyle ?? CustomButtonStyle.primaryButtonTheme,
        onPressed: loading ? null : onPressed,
        child: loading
            ? SizedBox(
                width: 20.w,
                height: 20.h,
                child: const CircularProgressIndicator.adaptive(),
              )
            : Row(
                mainAxisAlignment: alignment ?? MainAxisAlignment.center,
                children: [
                  if (leftIcon != null) ...[
                    leftIcon!,
                    SizedBox(width: 8.w),
                  ],
                  Text(
                    text,
                    style: textStyle ??
                        CustomTextStyle.textBaseMedium.copyWith(
                          color: textColor ?? appTheme.otherWhite,
                        ),
                  ),
                  if (buttonIcon != null)
                    Icon(
                      buttonIcon,
                      color: appTheme.otherWhite,
                      size: 24.h,
                    ),
                ],
              ));
  }
}
