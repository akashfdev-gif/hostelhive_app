import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/core/models/complaint_model.dart';
import 'package:intl/intl.dart';

class TrackComplaintDetailScreen extends StatelessWidget {
  final ComplaintModel initialComplaint;

  const TrackComplaintDetailScreen({super.key, required this.initialComplaint});

  @override
  Widget build(BuildContext context) {
    final complaint = initialComplaint;

    return Scaffold(
      backgroundColor: appTheme.otherBackground,
      appBar: CustomAppBar(
        title: 'lbl_complaint_details'.tr,
        centerTitle: true,
        backgroundColor: appTheme.blue900,
        toolbarHeight: 64.h,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16.h,
          children: [
            _buildStatusBadge(complaint),
            _buildProgressTimeline(complaint),
            _buildAdminMessage(complaint),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(ComplaintModel complaint) {
    Color statusColor;
    IconData icon;
    String desc;

    switch (complaint.status.toLowerCase()) {
      case 'pending':
        statusColor = appTheme.orange900;
        icon = Icons.hourglass_empty_rounded;
        desc = 'msg_status_pending_desc'.tr;
        break;
      case 'received':
      case 'assigned':
      case 'in progress':
        statusColor = appTheme.blue700;
        icon = Icons.sync_rounded;
        desc = 'msg_status_in_progress_desc'.tr;
        break;
      case 'resolved':
        statusColor = appTheme.green700;
        icon = Icons.check_circle_rounded;
        desc = 'msg_status_resolved_desc'.tr;
        break;
      case 'rejected':
        statusColor = appTheme.red900;
        icon = Icons.cancel_rounded;
        desc = 'msg_status_rejected_desc'.tr;
        break;
      default:
        statusColor = appTheme.black500;
        icon = Icons.info_outline;
        desc = '';
    }

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
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.h),
                  border: Border.all(color: statusColor.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 6.w,
                  children: [
                    Icon(icon, color: statusColor, size: 16.h),
                    Text(
                      complaint.status,
                      style: CustomTextStyle.textSmSemiBold
                          .copyWith(color: statusColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            desc,
            style: CustomTextStyle.textXsRegular
                .copyWith(color: appTheme.black600),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressTimeline(ComplaintModel complaint) {
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
          _buildTimelineStep(
            'Complaint Submitted',
            complaint.createdAt,
            isCompleted: true, // Always true
          ),
          _buildTimelineStep(
            'Received by Admin',
            complaint.receivedAt,
            isCompleted: complaint.receivedAt != null,
          ),
          _buildTimelineStep(
            'Assigned to Maintenance',
            complaint.assignedAt,
            isCompleted: complaint.assignedAt != null,
          ),
          _buildTimelineStep(
            'In Progress',
            complaint.inProgressAt,
            isCompleted: complaint.inProgressAt != null,
          ),
          _buildTimelineStep(
            'Resolved',
            complaint.resolvedAt,
            isCompleted: complaint.resolvedAt != null,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStep(String title, DateTime? time,
      {bool isCompleted = false, bool isLast = false}) {
    final color = isCompleted ? appTheme.green700 : appTheme.black200;
    final icon = isCompleted
        ? Icons.check_circle_rounded
        : Icons.radio_button_unchecked_rounded;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.w,
        children: [
          Column(
            children: [
              Icon(icon, color: color, size: 24.h),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isCompleted ? appTheme.green700 : appTheme.black200,
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                  ),
                ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2.h,
                children: [
                  Text(
                    title,
                    style: CustomTextStyle.textSmMedium.copyWith(
                      color: isCompleted ? appTheme.black800 : appTheme.black400,
                    ),
                  ),
                  if (time != null)
                    Text(
                      DateFormat('dd MMM yyyy, hh:mm a').format(time),
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

  Widget _buildAdminMessage(ComplaintModel complaint) {
    final hasMessage = complaint.adminMessage.isNotEmpty;

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
          Row(
            spacing: 8.w,
            children: [
              Icon(Icons.admin_panel_settings_outlined,
                  color: appTheme.blue800, size: 20.h),
              Text(
                'lbl_admin_message'.tr,
                style: CustomTextStyle.textBaseSemiBold
                    .copyWith(color: appTheme.black900),
              ),
            ],
          ),
          Divider(color: appTheme.otherBorder, height: 1),
          if (hasMessage)
            Container(
              padding: EdgeInsets.all(12.h),
              decoration: BoxDecoration(
                color: appTheme.blueGrey50,
                borderRadius: BorderRadius.circular(8.h),
                border: Border.all(
                    color: appTheme.blue100.withValues(alpha: 0.6)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8.w,
                children: [
                  Icon(Icons.format_quote_rounded,
                      color: appTheme.blue700, size: 18.h),
                  Expanded(
                    child: Text(
                      complaint.adminMessage,
                      style: CustomTextStyle.textSmRegular
                          .copyWith(color: appTheme.black700),
                    ),
                  ),
                ],
              ),
            )
          else
            Row(
              spacing: 8.w,
              children: [
                Icon(Icons.info_outline, color: appTheme.black400, size: 16.h),
                Text(
                  'No updates yet',
                  style: CustomTextStyle.textSmRegular
                      .copyWith(color: appTheme.black500),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
