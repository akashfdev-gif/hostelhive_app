import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/admin_screens/bloc/admin_dashboard_bloc.dart';
import 'package:hostel_hive/features/dashboard_screen/widgets/dashboard_section_card.dart';

class AdminHomeTab extends StatelessWidget {
  const AdminHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20.h,
        children: [
          _WelcomeCard(),
          _StatsSection(),
          _QuickActionsSection(),
          DashboardSectionCard(
            title: 'lbl_latest_notice'.tr,
            child: Text(
              'msg_notice_preview'.tr,
              style: CustomTextStyle.textSmRegular.copyWith(
                color: appTheme.black600,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [appTheme.blue900, appTheme.blue700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.h),
        boxShadow: appTheme.cardShadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16.w,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                Text(
                  'msg_welcome_back'.tr,
                  style: CustomTextStyle.textSmRegular.copyWith(
                    color: appTheme.otherWhite.withValues(alpha: 0.9),
                  ),
                ),
                Text(
                  'Admin',
                  style: CustomTextStyle.textXlBold.copyWith(
                    color: appTheme.otherWhite,
                  ),
                ),
                Text(
                  'Hostel Manager',
                  style: CustomTextStyle.textSmMedium.copyWith(
                    color: appTheme.blue100,
                  ),
                ),
              ],
            ),
          ),
          NamedAvatar(
            name: 'Admin',
            radius: 28.h,
            fontSize: 18.fSize,
          ),
        ],
      ),
    );
  }
}

class _StatsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12.h,
      children: [
        Row(
          spacing: 12.w,
          children: [
            Expanded(
              child: _StatCard(
                label: 'lbl_total_students'.tr,
                value: '150',
                icon: Icons.groups,
                color: appTheme.blue50,
                iconColor: appTheme.blue700,
              ),
            ),
            Expanded(
              child: _StatCard(
                label: 'lbl_pending_complaints'.tr,
                value: '8',
                icon: Icons.report_problem,
                color: appTheme.orange50,
                iconColor: appTheme.orange700,
              ),
            ),
          ],
        ),
        _StatCard(
          label: 'lbl_todays_meals_status'.tr,
          value: 'On Track',
          icon: Icons.restaurant,
          color: appTheme.green50,
          iconColor: appTheme.green700,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.iconColor,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(color: appTheme.otherBorder),
      ),
      child: Row(
        spacing: 12.w,
        children: [
          Container(
            padding: EdgeInsets.all(10.h),
            decoration: BoxDecoration(
              color: appTheme.otherWhite,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24.h,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                Text(
                  label,
                  style: CustomTextStyle.textXsRegular.copyWith(
                    color: appTheme.black600,
                  ),
                ),
                Text(
                  value,
                  style: CustomTextStyle.textLgBold.copyWith(
                    color: appTheme.black900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12.h,
      children: [
        Text(
          'lbl_quick_actions_admin'.tr,
          style: CustomTextStyle.textBaseSemiBold.copyWith(
            color: appTheme.black900,
          ),
        ),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            _QuickActionChip(
              label: 'lbl_add_student'.tr,
              icon: Icons.person_add_outlined,
            ),
            _QuickActionChip(
              label: 'lbl_update_menu'.tr,
              icon: Icons.restaurant_menu_outlined,
            ),
            _QuickActionChip(
              label: 'lbl_resolve_complaint'.tr,
              icon: Icons.check_circle_outline,
            ),
            _QuickActionChip(
              label: 'lbl_send_notice'.tr,
              icon: Icons.notification_add_outlined,
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickActionChip extends StatelessWidget {
  const _QuickActionChip({
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: Implement quick action
      },
      borderRadius: BorderRadius.circular(10.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: appTheme.blueGrey50,
          borderRadius: BorderRadius.circular(10.h),
          border: Border.all(color: appTheme.otherBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8.w,
          children: [
            Icon(icon, size: 18.h, color: appTheme.blue800),
            Text(
              label,
              style: CustomTextStyle.textSmMedium.copyWith(
                color: appTheme.blue900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
