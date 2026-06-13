import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';

class AdminRemarksCard extends StatelessWidget {
  const AdminRemarksCard({super.key, required this.remark});

  final String? remark;

  @override
  Widget build(BuildContext context) {
    final hasRemark = remark != null && remark!.isNotEmpty;

    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: appTheme.otherWhite,
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(color: appTheme.otherBorder),
        boxShadow: appTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.h,
        children: [
          Row(
            spacing: 8.w,
            children: [
              Icon(Icons.admin_panel_settings_outlined,
                  color: appTheme.blue800, size: 20.h),
              Text(
                'lbl_admin_message'.tr,
                style: CustomTextStyle.textBaseSemiBold
                    .copyWith(color: appTheme.black900),
              ),
            ],
          ),
          Divider(color: appTheme.otherBorder, height: 1),
          if (hasRemark)
            Container(
              padding: EdgeInsets.all(12.h),
              decoration: BoxDecoration(
                color: appTheme.blueGrey50,
                borderRadius: BorderRadius.circular(8.h),
                border: Border.all(
                    color: appTheme.blue100.withValues(alpha: 0.6)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8.w,
                children: [
                  Icon(Icons.format_quote_rounded,
                      color: appTheme.blue700, size: 18.h),
                  Expanded(
                    child: Text(
                      remark!.tr,
                      style: CustomTextStyle.textSmRegular
                          .copyWith(color: appTheme.black700),
                    ),
                  ),
                ],
              ),
            )
          else
            Row(
              spacing: 8.w,
              children: [
                Icon(Icons.info_outline,
                    color: appTheme.black400, size: 16.h),
                Text(
                  'msg_no_remarks'.tr,
                  style: CustomTextStyle.textSmRegular
                      .copyWith(color: appTheme.black500),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
