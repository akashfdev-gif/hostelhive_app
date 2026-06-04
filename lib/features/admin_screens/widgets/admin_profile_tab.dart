import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/dashboard_screen/widgets/dashboard_section_card.dart';

class AdminProfileTab extends StatelessWidget {
  const AdminProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 20.h,
        children: [
          NamedAvatar(
            name: 'Admin',
            radius: 40.h,
            fontSize: 24.fSize,
          ),
          Text(
            'Admin',
            style: CustomTextStyle.textXlBold.copyWith(
              color: appTheme.black900,
            ),
          ),
          Text(
            'Hostel Manager',
            style: CustomTextStyle.textSmMedium.copyWith(
              color: appTheme.gray600,
            ),
          ),
          DashboardSectionCard(
            title: 'Admin Details',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10.h,
              children: [
                _DetailRow(
                  icon: Icons.email_outlined,
                  label: 'lbl_email'.tr,
                  value: 'admin@hostelhive.com',
                ),
                _DetailRow(
                  icon: Icons.phone_outlined,
                  label: 'lbl_phone'.tr,
                  value: '+91 98765 43210',
                ),
              ],
            ),
          ),
          Text(
            'lbl_settings'.tr,
            style: CustomTextStyle.textBaseSemiBold.copyWith(
              color: appTheme.black900,
            ),
          ),
          _SettingsTile(
            icon: Icons.edit_outlined,
            title: 'lbl_edit_profile'.tr,
          ),
          CustomElevatedButton(
            text: 'lbl_logout'.tr,
            buttonStyle: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 48.h),
              backgroundColor: appTheme.red50,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.h),
                side: BorderSide(color: theme.colorScheme.primary),
              ),
            ),
            textColor: theme.colorScheme.primary,
            onPressed: () {
              NavigatorService.pushNamedAndRemoveUntil(
                AppRoutes.walkthroughScreen,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.w,
      children: [
        Icon(icon, size: 20.h, color: appTheme.blue700),
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

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: appTheme.otherWhite,
      borderRadius: BorderRadius.circular(10.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.h),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.h),
            border: Border.all(color: appTheme.otherBorder),
          ),
          child: Row(
            spacing: 12.w,
            children: [
              Icon(icon, color: appTheme.blue800, size: 22.h),
              Expanded(
                child: Text(
                  title,
                  style: CustomTextStyle.textBaseMedium.copyWith(
                    color: appTheme.black900,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, color: appTheme.gray500),
            ],
          ),
        ),
      ),
    );
  }
}
