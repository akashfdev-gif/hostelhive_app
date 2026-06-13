import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/track_status/bloc/track_status_bloc.dart';

class ComplaintInfoCard extends StatelessWidget {
  const ComplaintInfoCard({super.key, required this.state});

  final TrackStatusState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: appTheme.otherWhite,
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(color: appTheme.otherBorder),
        boxShadow: appTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.h,
        children: [
          Text(
            'lbl_complaint_info'.tr,
            style: CustomTextStyle.textBaseSemiBold
                .copyWith(color: appTheme.black900),
          ),
          Divider(color: appTheme.otherBorder, height: 1),
          _InfoRow(
            labelKey: 'lbl_complaint_id',
            value: state.complaintId,
            isHighlighted: true,
          ),
          _InfoRow(
            labelKey: 'lbl_category',
            value: state.category.tr,
          ),
          _InfoRow(
            labelKey: 'lbl_complaint_title',
            value: state.title.tr,
          ),
          _InfoRow(
            labelKey: 'lbl_submitted_on',
            value: state.submittedOn.tr,
          ),
          _InfoRow(
            labelKey: 'lbl_priority',
            value: state.priority.tr,
            priorityColor: _priorityColor(state.priority),
          ),
        ],
      ),
    );
  }

  Color _priorityColor(String priorityKey) {
    switch (priorityKey) {
      case 'lbl_high':
        return appTheme.red900;
      case 'lbl_medium':
        return appTheme.orange900;
      default:
        return appTheme.green700;
    }
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.labelKey,
    required this.value,
    this.isHighlighted = false,
    this.priorityColor,
  });

  final String labelKey;
  final String value;
  final bool isHighlighted;
  final Color? priorityColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            labelKey.tr,
            style: CustomTextStyle.textXsRegular
                .copyWith(color: appTheme.black500),
          ),
        ),
        Text(
          ': ',
          style: CustomTextStyle.textXsRegular
              .copyWith(color: appTheme.black500),
        ),
        Expanded(
          flex: 6,
          child: Text(
            value,
            style: CustomTextStyle.textXsMedium.copyWith(
              color: priorityColor ??
                  (isHighlighted ? appTheme.blue800 : appTheme.black800),
              fontWeight:
                  isHighlighted ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
