import 'package:book_store/core/constant/icon_constant.dart';
import 'package:book_store/core/localization/app_localization.dart';
import 'package:book_store/core/utils/size_utils.dart';
import 'package:book_store/themes/custom_text_style.dart';
import 'package:book_store/themes/theme_helper.dart';
import 'package:book_store/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:book_store/v2/core/app_export.dart';

class HelpChip extends StatelessWidget {
  final void Function()? onTap;
  const HelpChip({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 4.w),
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          width: 64.w,
          height: 20.h,
          decoration: BoxDecoration(
              color: appTheme.blue100,
              borderRadius: BorderRadius.circular(80.fSize)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomImageView(
                imagePath: IconConstant.icBackArrow,
                fit: BoxFit.scaleDown,
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: Text(
                  "msg_help_chip".tr,
                  style: CustomTextStyle.textXsSemiBold
                      .copyWith(color: appTheme.blue600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
