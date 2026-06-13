import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/track_status/bloc/track_status_bloc.dart';

class ProgressTimeline extends StatelessWidget {
  const ProgressTimeline({super.key, required this.steps});

  final List<ComplaintTimelineStep> steps;

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
            'lbl_progress_timeline'.tr,
            style: CustomTextStyle.textBaseSemiBold
                .copyWith(color: appTheme.black900),
          ),
          Divider(color: appTheme.otherBorder, height: 1),
          ListView.builder(
            itemCount: steps.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final step = steps[index];
              final isLast = index == steps.length - 1;
              return _TimelineItem(
                step: step,
                isLast: isLast,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({required this.step, required this.isLast});

  final ComplaintTimelineStep step;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final color = _stepColor(step.stepStatus);
    final icon = _stepIcon(step.stepStatus);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.w,
        children: [
          // Icon + connector line column
          Column(
            children: [
              Container(
                width: 32.h,
                height: 32.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withValues(alpha: 0.12),
                  border: Border.all(color: color, width: 1.5),
                ),
                child: Icon(icon, color: color, size: 16.h),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: appTheme.otherBorder,
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                  ),
                ),
            ],
          ),
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2.h,
                children: [
                  Text(
                    step.titleKey.tr,
                    style: CustomTextStyle.textSmMedium.copyWith(
                      color: step.stepStatus == StepStatus.upcoming
                          ? appTheme.black400
                          : appTheme.black800,
                    ),
                  ),
                  if (step.dateTime != null)
                    Text(
                      step.dateTime!.tr,
                      style: CustomTextStyle.textXsRegular
                          .copyWith(color: appTheme.black500),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _stepColor(StepStatus status) {
    switch (status) {
      case StepStatus.completed:
        return appTheme.green700;
      case StepStatus.active:
        return appTheme.blue700;
      case StepStatus.upcoming:
        return appTheme.black200;
    }
  }

  IconData _stepIcon(StepStatus status) {
    switch (status) {
      case StepStatus.completed:
        return Icons.check_rounded;
      case StepStatus.active:
        return Icons.sync_rounded;
      case StepStatus.upcoming:
        return Icons.radio_button_unchecked_rounded;
    }
  }
}
