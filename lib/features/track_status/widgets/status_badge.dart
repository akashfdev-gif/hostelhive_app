import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/track_status/bloc/track_status_bloc.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final ComplaintStatus status;

  @override
  Widget build(BuildContext context) {
    final config = _statusConfig(status);

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
            'lbl_current_status'.tr,
            style: CustomTextStyle.textBaseSemiBold
                .copyWith(color: appTheme.black900),
          ),
          Divider(color: appTheme.otherBorder, height: 1),
          Row(
            spacing: 12.w,
            children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: config.bgColor,
                  borderRadius: BorderRadius.circular(20.h),
                  border: Border.all(color: config.borderColor),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 6.w,
                  children: [
                    Icon(config.icon, color: config.iconColor, size: 16.h),
                    Text(
                      config.labelKey.tr,
                      style: CustomTextStyle.textSmSemiBold
                          .copyWith(color: config.iconColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            config.descKey.tr,
            style: CustomTextStyle.textXsRegular
                .copyWith(color: appTheme.black600),
          ),
        ],
      ),
    );
  }

  _StatusConfig _statusConfig(ComplaintStatus status) {
    switch (status) {
      case ComplaintStatus.pending:
        return _StatusConfig(
          labelKey: 'lbl_status_pending',
          descKey: 'msg_status_pending_desc',
          icon: Icons.hourglass_empty_rounded,
          iconColor: appTheme.orange900,
          bgColor: appTheme.orange50,
          borderColor: appTheme.orange900.withValues(alpha: 0.3),
        );
      case ComplaintStatus.inProgress:
        return _StatusConfig(
          labelKey: 'lbl_status_in_progress',
          descKey: 'msg_status_in_progress_desc',
          icon: Icons.sync_rounded,
          iconColor: appTheme.blue700,
          bgColor: appTheme.blue100.withValues(alpha: 0.4),
          borderColor: appTheme.blue700.withValues(alpha: 0.3),
        );
      case ComplaintStatus.resolved:
        return _StatusConfig(
          labelKey: 'lbl_status_resolved',
          descKey: 'msg_status_resolved_desc',
          icon: Icons.check_circle_rounded,
          iconColor: appTheme.green700,
          bgColor: appTheme.green50,
          borderColor: appTheme.green700.withValues(alpha: 0.3),
        );
      case ComplaintStatus.rejected:
        return _StatusConfig(
          labelKey: 'lbl_status_rejected',
          descKey: 'msg_status_rejected_desc',
          icon: Icons.cancel_rounded,
          iconColor: appTheme.red900,
          bgColor: appTheme.red50,
          borderColor: appTheme.red900.withValues(alpha: 0.3),
        );
    }
  }
}

class _StatusConfig {
  const _StatusConfig({
    required this.labelKey,
    required this.descKey,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.borderColor,
  });

  final String labelKey;
  final String descKey;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final Color borderColor;
}
