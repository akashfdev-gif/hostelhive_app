import 'package:book_store/core/utils/size_utils.dart';
import 'package:book_store/themes/theme_helper.dart';
import 'package:hostel_hive/core/utils/size_utils.dart';
import 'package:hostel_hive/themes/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';

class CustomButtonStyle {
  static ButtonStyle get primaryButtonTheme => ElevatedButton.styleFrom(
        fixedSize: Size(double.maxFinite, 48.h),
        disabledBackgroundColor: appTheme.blue100,
        padding: EdgeInsets.symmetric(
          vertical: 13.h,
          horizontal: 12.w,
        ),
        overlayColor: appTheme.blue100,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.h),
        ),
      );
  static ButtonStyle get outlinedButtonTheme => OutlinedButton.styleFrom(
      backgroundColor: appTheme.otherWhite,
      fixedSize: Size(double.maxFinite, 48.h),
      disabledBackgroundColor: appTheme.blue100,
      padding: EdgeInsets.symmetric(
        vertical: 13.h,
        horizontal: 20.w,
      ),
      overlayColor: appTheme.black100,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: theme.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(12.h)));
  static ButtonStyle get secondaryButtonTheme => ElevatedButton.styleFrom(
        fixedSize: Size(double.maxFinite, 48.h),
        disabledBackgroundColor: appTheme.blue100,
        padding: EdgeInsets.symmetric(
          vertical: 13.h,
          horizontal: 20.w,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.h),
        ),
      );
}