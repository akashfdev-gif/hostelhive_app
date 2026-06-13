import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/dashboard_screen/widgets/dashboard_section_card.dart';
import 'package:hostel_hive/features/upload_images/upload_images_screen.dart';

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
                  onPressed: () {},
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
          DashboardSectionCard(
            title: 'lbl_complaint_history'.tr,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12.h,
              children: [
                _HistoryItem(
                  text: 'msg_complaint_resolved'.tr,
                  isResolved: true,
                ),
                Divider(color: appTheme.gray200, height: 1),
                _HistoryItem(
                  text: 'msg_complaint_pending'.tr,
                  isResolved: false,
                ),
              ],
            ),
          ),
        ],
      ),
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

class _HistoryItem extends StatelessWidget {
  const _HistoryItem({required this.text, required this.isResolved});

  final String text;
  final bool isResolved;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.w,
      children: [
        Icon(
          isResolved ? Icons.check_circle_outline : Icons.schedule,
          color: isResolved ? appTheme.green700 : appTheme.orange900,
          size: 20.h,
        ),
        Expanded(
          child: Text(
            text,
            style: CustomTextStyle.textSmRegular.copyWith(
              color: appTheme.black700,
            ),
          ),
        ),
      ],
    );
  }
}
