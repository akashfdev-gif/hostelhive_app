import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';

class AdminStudentsTab extends StatelessWidget {
  const AdminStudentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20.h,
        children: [
          DashboardSectionCard(
            title: 'lbl_manage_students'.tr,
            child: Column(
              spacing: 16.h,
              children: [
                CustomElevatedButton(
                  text: 'lbl_view_student_list'.tr,
                  onPressed: () {
                    // TODO: Implement view student list
                  },
                ),
                CustomElevatedButton(
                  text: 'lbl_view_payments'.tr,
                  buttonStyle: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(appTheme.otherWhite),
                  ),
                  onPressed: () {
                    // TODO: Implement view payments
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
