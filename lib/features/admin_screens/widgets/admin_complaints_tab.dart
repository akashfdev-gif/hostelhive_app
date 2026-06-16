import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/admin_screens/bloc/admin_dashboard_bloc.dart';
import 'package:hostel_hive/core/models/complaint_model.dart';

class AdminComplaintsTab extends StatelessWidget {
  const AdminComplaintsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminDashboardBloc, AdminDashboardState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.errorMessage != null) {
          return Center(child: Text(state.errorMessage!));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16.h,
            children: state.complaints.isEmpty
                ? [Center(child: Text('lbl_no_complaints_found'.tr))]
                : state.complaints.map((complaint) {
                    return _buildComplaintAdminCard(context, complaint);
                  }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildComplaintAdminCard(BuildContext context, ComplaintModel complaint) {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: appTheme.otherWhite,
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(color: appTheme.otherBorder),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  complaint.title,
                  style: CustomTextStyle.textLgSemiBold.copyWith(
                    color: appTheme.black900,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _getStatusColor(complaint.status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.h),
                ),
                child: Text(
                  complaint.status,
                  style: CustomTextStyle.textXsMedium.copyWith(
                    color: _getStatusColor(complaint.status),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            complaint.description,
            style: CustomTextStyle.textSmRegular.copyWith(
              color: appTheme.black600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Room: ${complaint.roomNumber} - ${complaint.studentName}",
                style: CustomTextStyle.textXsMedium.copyWith(
                  color: appTheme.black800,
                ),
              ),
              Text(
                complaint.createdAt.toString().split(' ')[0],
                style: CustomTextStyle.textXsRegular.copyWith(
                  color: appTheme.black400,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          CustomElevatedButton(
            text: 'Update Status',
            height: 40.h,
            onPressed: () {
              _showUpdateStatusDialog(context, complaint);
            },
          ),
        ],
      ),
    );
  }

  void _showUpdateStatusDialog(BuildContext context, ComplaintModel complaint) {
    String selectedStatus = complaint.status;
    String adminMessage = complaint.adminMessage;

    final statuses = ['Pending', 'Received', 'Assigned', 'In Progress', 'Resolved', 'Rejected'];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: appTheme.otherBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.h)),
      ),
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (statefulContext, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(statefulContext).viewInsets.bottom,
                left: 20.w,
                right: 20.w,
                top: 24.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 16.h,
                children: [
                  Text(
                    'Update Complaint Status',
                    style: CustomTextStyle.textLgSemiBold.copyWith(
                      color: appTheme.black900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  DropdownButtonFormField<String>(
                    value: statuses.contains(selectedStatus) ? selectedStatus : 'Pending',
                    decoration: InputDecoration(
                      labelText: 'Status',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.h),
                      ),
                    ),
                    items: statuses.map((status) {
                      return DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => selectedStatus = val);
                    },
                  ),
                  TextFormField(
                    initialValue: adminMessage,
                    decoration: InputDecoration(
                      labelText: 'Admin Message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.h),
                      ),
                    ),
                    maxLines: 3,
                    onChanged: (val) {
                      adminMessage = val;
                    },
                  ),
                  CustomElevatedButton(
                    text: 'Save Update',
                    onPressed: () {
                      context.read<AdminDashboardBloc>().add(
                            UpdateComplaintStatusEvent(
                              complaintId: complaint.id,
                              newStatus: selectedStatus,
                              adminMessage: adminMessage,
                            ),
                          );
                      Navigator.pop(statefulContext);
                    },
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return appTheme.orange900;
      case 'received':
      case 'assigned':
      case 'in progress':
        return appTheme.blue500;
      case 'resolved':
        return appTheme.green500;
      case 'rejected':
        return appTheme.red500;
      default:
        return appTheme.black500;
    }
  }
}
