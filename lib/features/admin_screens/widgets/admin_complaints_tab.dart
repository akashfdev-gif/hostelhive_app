import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';

class AdminComplaintsTab extends StatelessWidget {
  const AdminComplaintsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20.h,
        children: [
          DashboardSectionCard(
            title: 'lbl_manage_complaints'.tr,
            child: Column(
              spacing: 16.h,
              children: [
                Text(
                  'You can manage all student complaints here.',
                  style: CustomTextStyle.textSmRegular.copyWith(
                    color: appTheme.black600,
                  ),
                ),
                CustomElevatedButton(
                  text: 'lbl_mark_resolved'.tr,
                  onPressed: () {
                    // TODO: Implement mark as resolved
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
