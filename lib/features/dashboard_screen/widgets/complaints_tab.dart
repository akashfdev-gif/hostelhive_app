import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/core/models/complaint_model.dart';
import 'package:hostel_hive/features/dashboard_screen/widgets/dashboard_section_card.dart';
import 'package:hostel_hive/features/upload_images/upload_images_screen.dart';
import 'package:intl/intl.dart';

class ComplaintsTab extends StatelessWidget {
  const ComplaintsTab({super.key});

  static const _categories = [
    ('lbl_electricity', Icons.bolt_outlined, Color(0xFFFFC107)),
    ('lbl_water', Icons.water_drop_outlined, Color(0xFF2196F3)),
    ('lbl_wifi', Icons.wifi_outlined, Color(0xFF9C27B0)),
    ('lbl_cleaning', Icons.cleaning_services_outlined, Color(0xFF4CAF50)),
    ('lbl_food_category', Icons.fastfood_outlined, Color(0xFFFF5722)),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20.h,
        children: [
          CustomElevatedButton(
            text: 'lbl_new_complaint'.tr,
            leftIcon: Icon(Icons.add, color: appTheme.otherWhite, size: 22.h),
            onPressed: () {
              NavigatorService.pushNamed(AppRoutes.addNewComplaintScreen);
            },
          ),
          Row(
            spacing: 12.w,
            children: [
              Expanded(
                child: CustomElevatedButton(
                  text: 'lbl_upload_image'.tr,
                  buttonStyle: CustomButtonStyle.outlinedButtonTheme,
                  textColor: theme.colorScheme.primary,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            UploadImagesScreen.builder(context),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: CustomElevatedButton(
                  text: 'lbl_track_status'.tr,
                  buttonStyle: CustomButtonStyle.outlinedButtonTheme,
                  textColor: theme.colorScheme.primary,
                  onPressed: () {
                    NavigatorService.pushNamed(AppRoutes.trackStatusScreen);
                  },
                ),
              ),
            ],
          ),
          Text(
            'lbl_complaints_section'.tr,
            style: CustomTextStyle.textBaseSemiBold.copyWith(
              color: appTheme.black900,
            ),
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 12.w,
            childAspectRatio: 1.6,
            children: _categories
                .map(
                  (item) => _CategoryCard(
                    labelKey: item.$1,
                    icon: item.$2,
                    color: item.$3,
                  ),
                )
                .toList(),
          ),
          _buildComplaintHistory(),
        ],
      ),
    );
  }

  Widget _buildComplaintHistory() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return DashboardSectionCard(
        title: 'lbl_complaint_history'.tr,
        child: Text(
          'Please login to view complaint history',
          style: CustomTextStyle.textSmRegular
              .copyWith(color: appTheme.black500),
        ),
      );
    }

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('complaints')
          .where('studentId', isEqualTo: uid)
          .orderBy('createdAt', descending: true)
          .limit(5)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return DashboardSectionCard(
            title: 'lbl_complaint_history'.tr,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(12.h),
                child: SizedBox(
                  height: 24.h,
                  width: 24.h,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return DashboardSectionCard(
            title: 'lbl_complaint_history'.tr,
            child: Text(
              'Unable to load history',
              style: CustomTextStyle.textSmRegular
                  .copyWith(color: appTheme.red500),
            ),
          );
        }

        final docs = snapshot.data?.docs ?? [];
        if (docs.isEmpty) {
          return DashboardSectionCard(
            title: 'lbl_complaint_history'.tr,
            child: Row(
              spacing: 8.w,
              children: [
                Icon(Icons.info_outline, color: appTheme.black400, size: 18.h),
                Text(
                  'No complaints yet',
                  style: CustomTextStyle.textSmRegular
                      .copyWith(color: appTheme.black500),
                ),
              ],
            ),
          );
        }

        final complaints = docs
            .map((doc) => ComplaintModel.fromFirestore(doc))
            .toList();

        return DashboardSectionCard(
          title: 'lbl_complaint_history'.tr,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < complaints.length; i++) ...[
                if (i > 0) Divider(color: appTheme.gray200, height: 1),
                if (i > 0) SizedBox(height: 12.h),
                _ComplaintHistoryItem(complaint: complaints[i]),
                if (i < complaints.length - 1) SizedBox(height: 12.h),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.labelKey,
    required this.icon,
    required this.color,
  });

  final String labelKey;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: appTheme.otherWhite,
      borderRadius: BorderRadius.circular(12.h),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12.h),
        child: Container(
          padding: EdgeInsets.all(14.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.h),
            border: Border.all(color: appTheme.otherBorder),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8.h,
            children: [
              Icon(icon, color: color, size: 28.h),
              Text(
                labelKey.tr,
                style: CustomTextStyle.textSmSemiBold.copyWith(
                  color: appTheme.black800,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ComplaintHistoryItem extends StatelessWidget {
  const _ComplaintHistoryItem({required this.complaint});

  final ComplaintModel complaint;

  @override
  Widget build(BuildContext context) {
    final isResolved = complaint.status.toLowerCase() == 'resolved';
    final isRejected = complaint.status.toLowerCase() == 'rejected';

    IconData icon;
    Color color;

    if (isResolved) {
      icon = Icons.check_circle_outline;
      color = appTheme.green700;
    } else if (isRejected) {
      icon = Icons.cancel_outlined;
      color = appTheme.red500;
    } else if (complaint.status.toLowerCase() == 'in progress' ||
        complaint.status.toLowerCase() == 'assigned') {
      icon = Icons.sync_rounded;
      color = appTheme.blue500;
    } else {
      icon = Icons.schedule;
      color = appTheme.orange900;
    }

    final dateStr = DateFormat('dd MMM').format(complaint.createdAt);
    final statusText = isResolved
        ? 'Resolved on $dateStr'
        : isRejected
            ? 'Rejected'
            : complaint.status;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.w,
      children: [
        Icon(icon, color: color, size: 20.h),
        Expanded(
          child: Text(
            '${complaint.category.tr} – $statusText',
            style: CustomTextStyle.textSmRegular.copyWith(
              color: appTheme.black700,
            ),
          ),
        ),
      ],
    );
  }
}

