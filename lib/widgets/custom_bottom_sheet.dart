import 'package:book_store/core/utils/navigator_service.dart';
import 'package:book_store/core/utils/size_utils.dart';
import 'package:book_store/themes/custom_button_style.dart';
import 'package:book_store/themes/custom_text_style.dart';
import 'package:book_store/themes/theme_helper.dart';
import 'package:book_store/widgets/custom_elevated_button.dart';
import 'package:hostel_hive/core/utils/navigator_service.dart';
import 'package:hostel_hive/core/utils/size_utils.dart';
import 'package:hostel_hive/themes/custom_button_style.dart';
import 'package:hostel_hive/themes/custom_text_style.dart';
import 'package:hostel_hive/themes/theme_helper.dart';
import 'package:hostel_hive/theme/custom_button_style.dart';
import 'package:hostel_hive/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';

class CustomBottomSheet {
  static void show({
    required BuildContext context,
    required List<Widget> children,
    required String title,
    double? height,
    bool isScrollControlled = false,
    bool hasButton = false,
    String? buttonText,
    Function()? onButtonPressed,
    double? maxHeight,
    bool dualButtons = false,
    Function()? onSecondButtonPressed,
    String? secondButtonText,
    Function()? onDismiss,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: appTheme.otherWhite,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      builder: (context) {
        return Padding(
          padding: (isScrollControlled)
              ? EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                )
              : const EdgeInsets.only(bottom: 0),
          child: Container(
            constraints: BoxConstraints(maxHeight: maxHeight ?? 472.h),
            height: height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60.w,
                  height: 4.h,
                  margin: EdgeInsets.symmetric(vertical: 4.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.fSize),
                      color: const Color(0xFFEBEBEB)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                        child: Text(
                          title,
                          style: CustomTextStyle.textXlSemiBold
                              .copyWith(color: appTheme.black900),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          if (onDismiss != null) {
                            onDismiss();
                          }
                          NavigatorService.goBack();
                        },
                        icon: Icon(
                          Icons.close,
                          size: 24.w,
                        ))
                  ],
                ),
                const Divider(),
                Expanded(
                    child: Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 12.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ...children,
                          ],
                        ))),
                if (hasButton)
                  Padding(
                    padding: EdgeInsets.only(
                        top: 16.h, left: 16.h, right: 16.h, bottom: 24.h),
                    child: (!dualButtons)
                        ? CustomElevatedButton(
                            text: buttonText ?? "",
                            onPressed: onButtonPressed,
                          )
                        : Row(
                            spacing: 8.w,
                            children: [
                              Expanded(
                                child: CustomElevatedButton(
                                  text: buttonText ?? "",
                                  onPressed: onButtonPressed,
                                ),
                              ),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: onSecondButtonPressed,
                                  style: CustomButtonStyle.outlinedButtonTheme,
                                  child: Text(
                                    secondButtonText ?? "",
                                    style: CustomTextStyle.textBaseMedium,
                                  ),
                                ),
                              )
                            ],
                          ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
