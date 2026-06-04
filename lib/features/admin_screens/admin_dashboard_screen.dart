import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/admin_screens/bloc/admin_dashboard_bloc.dart';
import 'package:hostel_hive/features/admin_screens/widgets/admin_bottom_nav_bar.dart';
import 'package:hostel_hive/features/admin_screens/widgets/admin_complaints_tab.dart';
import 'package:hostel_hive/features/admin_screens/widgets/admin_home_tab.dart';
import 'package:hostel_hive/features/admin_screens/widgets/admin_meals_tab.dart';
import 'package:hostel_hive/features/admin_screens/widgets/admin_profile_tab.dart';
import 'package:hostel_hive/features/admin_screens/widgets/admin_students_tab.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<AdminDashboardBloc>(
      create: (context) => AdminDashboardBloc()..add(AdminDashboardInitialEvent()),
      child: const AdminDashboardScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminDashboardBloc, AdminDashboardState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: appTheme.otherBackground,
          appBar: _buildAppBar(state.selectedTab),
          body: _buildBody(state.selectedTab),
          bottomNavigationBar: AdminBottomNavBar(
            selectedTab: state.selectedTab,
            onTabSelected: (tab) {
              context.read<AdminDashboardBloc>().add(
                    AdminTabChangedEvent(tab: tab),
                  );
            },
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(AdminTab tab) {
    return CustomAppBar(
      title: _appBarTitle(tab),
      centerTitle: true,
      backgroundColor: appTheme.blue900,
      toolbarHeight: 64.h,
      leading: const SizedBox.shrink(),
    );
  }

  String _appBarTitle(AdminTab tab) {
    switch (tab) {
      case AdminTab.home:
        return 'lbl_admin_dashboard'.tr;
      case AdminTab.complaints:
        return 'lbl_manage_complaints'.tr;
      case AdminTab.meals:
        return 'lbl_manage_meals'.tr;
      case AdminTab.students:
        return 'lbl_manage_students'.tr;
      case AdminTab.profile:
        return 'lbl_profile_section'.tr;
    }
  }

  Widget _buildBody(AdminTab tab) {
    switch (tab) {
      case AdminTab.home:
        return const AdminHomeTab();
      case AdminTab.complaints:
        return const AdminComplaintsTab();
      case AdminTab.meals:
        return const AdminMealsTab();
      case AdminTab.students:
        return const AdminStudentsTab();
      case AdminTab.profile:
        return const AdminProfileTab();
    }
  }
}
