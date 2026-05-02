import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';

class CustomConfirmDialogV2 extends StatelessWidget {
  final String message;
  final String successButtonText;
  final String failureButtonText;
  final VoidCallback onSuccessPressed;
  final VoidCallback onFailurePressed;
  final TextStyle? messageTextStyle;
  const CustomConfirmDialogV2(
      {super.key,
      required this.onFailurePressed,
      required this.successButtonText,
      required this.failureButtonText,
      required this.onSuccessPressed,
      required this.message,
      this.messageTextStyle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          child: Center(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: messageTextStyle ?? CustomTextStyle.textBaseRegular,
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            ),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.h),
                    child: OutlinedButton(
                      onPressed: onFailurePressed,
                      child: Text(
                        failureButtonText,
                        style: CustomTextStyle.textBaseMedium,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.h, bottom: 8.h, right: 8.h),
                    child: CustomElevatedButton(
                      text: successButtonText,
                      onPressed: onSuccessPressed,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static Future<void> showConfirmAlertV2(
    BuildContext context, {
    required String content,
    VoidCallback? onConfirmed,
    String? cancelButtonText,
    String? successButtonText,
    TextStyle? contentStyle,
    bool barrierDismissible = false,
  }) async {
    showDialog(
      // set [barrierDismissible] false if you don't want the dialog to be dismissed when user taps anywhere [![enter image description here][1]][1]outside of the alert
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: appTheme.otherWhite, // your color
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: CustomConfirmDialogV2(
            message: content,
            successButtonText: successButtonText ?? 'Confirm',
            failureButtonText: cancelButtonText ?? 'Cancel',
            messageTextStyle: contentStyle,
            onFailurePressed: () => Navigator.of(context).pop(),
            onSuccessPressed: () => Navigator.of(context).pop(true),
          ),
        );
      },
    ).then((value) {
      if (value != null && value && onConfirmed != null) {
        onConfirmed();
      }
    });
  }
}

class CustomAlertDialogV3 {
  static showAlertV3(
    BuildContext context, {
    required String content,
    VoidCallback? onConfirmed,
    String? cancelButtonText,
    String? successButtonText,
    VoidCallback? onCancelButtonClick,
    bool barrierDismissible = true,
  }) async {
    await showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) => Dialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(16.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.h),
                    color: appTheme.otherWhite,
                  ),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 12.h,
                      children: [
                        Text(content,
                            textAlign: TextAlign.center,
                            style: CustomTextStyle.textBaseRegular.copyWith(
                              color: appTheme.black600,
                            )),
                        if (successButtonText != null)
                          CustomElevatedButton(
                              onPressed: onConfirmed, text: successButtonText),
                        if (cancelButtonText != null)
                          CustomElevatedButton(
                              onPressed: onCancelButtonClick,
                              textColor: appTheme.blue900,
                              text: cancelButtonText),
                      ]),
                ),
              ],
            )));
  }
}
