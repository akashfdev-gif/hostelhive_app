import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/admin_screens/bloc/admin_dashboard_bloc.dart';

class AdminBottomNavBar extends StatelessWidget {
  const AdminBottomNavBar({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
  });

  final AdminTab selectedTab;
  final ValueChanged<AdminTab> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appTheme.otherWhite,
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Row(
            children: [
              _NavItem(
                tab: AdminTab.home,
                selectedTab: selectedTab,
                icon: Icons.dashboard_outlined,
                selectedIcon: Icons.dashboard,
                label: 'lbl_admin_nav_home'.tr,
                onTap: onTabSelected,
              ),
              _NavItem(
                tab: AdminTab.complaints,
                selectedTab: selectedTab,
                icon: Icons.report_problem_outlined,
                selectedIcon: Icons.report_problem,
                label: 'lbl_admin_nav_complaints'.tr,
                onTap: onTabSelected,
              ),
              _NavItem(
                tab: AdminTab.meals,
                selectedTab: selectedTab,
                icon: Icons.restaurant_outlined,
                selectedIcon: Icons.restaurant,
                label: 'lbl_admin_nav_meals'.tr,
                onTap: onTabSelected,
              ),
              _NavItem(
                tab: AdminTab.students,
                selectedTab: selectedTab,
                icon: Icons.groups_outlined,
                selectedIcon: Icons.groups,
                label: 'lbl_admin_nav_students'.tr,
                onTap: onTabSelected,
              ),
              _NavItem(
                tab: AdminTab.profile,
                selectedTab: selectedTab,
                icon: Icons.person_outline,
                selectedIcon: Icons.person,
                label: 'lbl_admin_nav_profile'.tr,
                onTap: onTabSelected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.tab,
    required this.selectedTab,
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.onTap,
  });

  final AdminTab tab;
  final AdminTab selectedTab;
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final ValueChanged<AdminTab> onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = tab == selectedTab;
    final color = isSelected ? theme.colorScheme.primary : appTheme.gray500;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(tab),
        borderRadius: BorderRadius.circular(8.h),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 4.h,
            children: [
              Icon(
                isSelected ? selectedIcon : icon,
                color: color,
                size: 24.h,
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: CustomTextStyle.textXsMedium.copyWith(color: color),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
