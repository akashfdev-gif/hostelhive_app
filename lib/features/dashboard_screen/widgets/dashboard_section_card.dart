import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';

class DashboardSectionCard extends StatelessWidget {
  const DashboardSectionCard({
    super.key,
    required this.title,
    this.trailing,
    required this.child,
    this.onTap,
  });

  final String title;
  final Widget? trailing;
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: appTheme.otherWhite,
      borderRadius: BorderRadius.circular(12.h),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.h),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.h),
            border: Border.all(color: appTheme.otherBorder),
            boxShadow: appTheme.cardShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12.h,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: CustomTextStyle.textBaseSemiBold.copyWith(
                        color: appTheme.black900,
                      ),
                    ),
                  ),
                  if (trailing != null) trailing!,
                ],
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
