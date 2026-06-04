import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';

class AdminMealsTab extends StatelessWidget {
  const AdminMealsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20.h,
        children: [
          DashboardSectionCard(
            title: 'lbl_manage_meals'.tr,
            child: Column(
              spacing: 16.h,
              children: [
                CustomElevatedButton(
                  text: 'lbl_edit_weekly_menu'.tr,
                  onPressed: () {
                    // TODO: Implement edit weekly menu
                  },
                ),
                CustomElevatedButton(
                  text: 'lbl_manage_meal_timings'.tr,
                  buttonStyle: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(appTheme.otherWhite),
                  ),
                  onPressed: () {
                    // TODO: Implement manage meal timings
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
