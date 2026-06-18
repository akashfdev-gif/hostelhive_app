import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';

class AdminContactDialog extends StatelessWidget {
  const AdminContactDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.h),
      ),
      title: Text(
        'lbl_key_contact_admin'.tr,
        style: CustomTextStyle.textBaseSemiBold.copyWith(
          color: appTheme.black900,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.h,
        children: [
          _ContactLine(
            label: 'lbl_admin_name'.tr,
            value: 'msg_admin_contact_name'.tr,
            icon: Icons.person_outline,
          ),
          _ContactLine(
            label: 'lbl_admin_phone'.tr,
            value: 'msg_admin_contact_phone'.tr,
            icon: Icons.phone_outlined,
          ),
          _ContactLine(
            label: 'lbl_admin_email'.tr,
            value: 'msg_admin_contact_email'.tr,
            icon: Icons.email_outlined,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'lbl_close'.tr,
            style: CustomTextStyle.textSmMedium.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactLine extends StatelessWidget {
  const _ContactLine({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.w,
      children: [
        Icon(icon, size: 18.h, color: appTheme.blue700),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2.h,
            children: [
              Text(
                label,
                style: CustomTextStyle.textXsMedium.copyWith(
                  color: appTheme.gray600,
                ),
              ),
              Text(
                value,
                style: CustomTextStyle.textSmRegular.copyWith(
                  color: appTheme.black800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
