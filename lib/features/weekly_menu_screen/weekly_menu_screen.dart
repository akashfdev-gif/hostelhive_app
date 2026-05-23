import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/dashboard_screen/widgets/dashboard_section_card.dart';
import 'package:hostel_hive/features/dashboard_screen/widgets/meal_menu_row.dart';
import 'package:hostel_hive/features/weekly_menu_screen/bloc/weekly_menu_bloc.dart';

class WeeklyMenuScreen extends StatelessWidget {
  const WeeklyMenuScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<WeeklyMenuBloc>(
      create: (context) => WeeklyMenuBloc()..add(WeeklyMenuInitialEvent()),
      child: const WeeklyMenuScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomRoundedScreen(
      appBarTitle: 'lbl_weekly_menu'.tr,
      scaffoldBackgroundColor: appTheme.blue900,
      appBarBackgroundColor: appTheme.blue900,
      bodyPadding: EdgeInsets.zero,
      body: BlocBuilder<WeeklyMenuBloc, WeeklyMenuState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20.h,
              children: state.weeklyMenu
                  .map((day) => _WeeklyDayCard(day: day))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}

class _WeeklyDayCard extends StatelessWidget {
  const _WeeklyDayCard({required this.day});

  final WeeklyMenuDayItem day;

  @override
  Widget build(BuildContext context) {
    return DashboardSectionCard(
      title: day.dayKey.tr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10.h,
        children: [
          MealMenuRow(
            meal: 'lbl_breakfast'.tr,
            menu: day.breakfastKey.tr,
          ),
          Divider(color: appTheme.gray200, height: 1),
          MealMenuRow(
            meal: 'lbl_lunch'.tr,
            menu: day.lunchKey.tr,
          ),
          Divider(color: appTheme.gray200, height: 1),
          MealMenuRow(
            meal: 'lbl_dinner'.tr,
            menu: day.dinnerKey.tr,
          ),
        ],
      ),
    );
  }
}
