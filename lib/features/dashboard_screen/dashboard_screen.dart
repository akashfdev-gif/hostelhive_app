import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:hostel_hive/features/dashboard_screen/widgets/complaints_tab.dart';
import 'package:hostel_hive/features/dashboard_screen/widgets/dashboard_bottom_nav_bar.dart';
import 'package:hostel_hive/features/dashboard_screen/widgets/home_tab.dart';
import 'package:hostel_hive/features/dashboard_screen/widgets/meals_tab.dart';
import 'package:hostel_hive/features/dashboard_screen/widgets/payments_tab.dart';
import 'package:hostel_hive/features/dashboard_screen/widgets/profile_tab.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<DashboardBloc>(
      create: (context) => DashboardBloc()..add(DashboardInitialEvent()),
      child: const DashboardScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: appTheme.otherBackground,
          appBar: _buildAppBar(state.selectedTab),
          body: _buildBody(state.selectedTab),
          bottomNavigationBar: DashboardBottomNavBar(
            selectedTab: state.selectedTab,
            onTabSelected: (tab) {
              context.read<DashboardBloc>().add(
                    DashboardTabChangedEvent(tab: tab),
                  );
            },
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(DashboardTab tab) {
    return CustomAppBar(
      title: _appBarTitle(tab),
      centerTitle: true,
      backgroundColor: appTheme.blue900,
      toolbarHeight: 64.h,
      leading: const SizedBox.shrink(),
    );
  }

  String _appBarTitle(DashboardTab tab) {
    switch (tab) {
      case DashboardTab.home:
        return 'lbl_dashboard'.tr;
      case DashboardTab.meals:
        return 'lbl_meals_section'.tr;
      case DashboardTab.complaints:
        return 'lbl_complaints_section'.tr;
      case DashboardTab.payments:
        return 'lbl_payments_section'.tr;
      case DashboardTab.profile:
        return 'lbl_profile_section'.tr;
    }
  }

  Widget _buildBody(DashboardTab tab) {
    switch (tab) {
      case DashboardTab.home:
        return const HomeTab();
      case DashboardTab.meals:
        return const MealsTab();
      case DashboardTab.complaints:
        return const ComplaintsTab();
      case DashboardTab.payments:
        return const PaymentsTab();
      case DashboardTab.profile:
        return const ProfileTab();
    }
  }
}
