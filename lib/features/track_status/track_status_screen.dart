import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/track_status/bloc/track_status_bloc.dart';
import 'package:hostel_hive/features/track_status/track_complaint_detail_screen.dart';


class TrackStatusScreen extends StatelessWidget {
  const TrackStatusScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<TrackStatusBloc>(
      create: (context) =>
          TrackStatusBloc()..add(const LoadComplaintStatusEvent()),
      child: const TrackStatusScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.otherBackground,
      appBar: CustomAppBar(
        title: 'lbl_track_complaint'.tr,
        centerTitle: true,
        backgroundColor: appTheme.blue900,
        toolbarHeight: 64.h,
      ),
      body: BlocBuilder<TrackStatusBloc, TrackStatusState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.errorMessage != null) {
            return Center(child: Text(state.errorMessage!));
          }
          if (state.complaints.isEmpty) {
            return Center(child: Text('lbl_no_complaints_found'.tr));
          }

          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            itemCount: state.complaints.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final complaint = state.complaints[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrackComplaintDetailScreen(
                        initialComplaint: complaint,
                      ),
                    ),
                  );
                },
                child: Container(
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: _getStatusColor(complaint.status)
                                  .withValues(alpha: 0.1),
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
                            complaint.category.tr,
                            style: CustomTextStyle.textXsMedium.copyWith(
                              color: appTheme.blue500,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 8.w,
                            children: [
                              Text(
                                complaint.createdAt.toString().split(' ')[0],
                                style: CustomTextStyle.textXsRegular.copyWith(
                                  color: appTheme.black400,
                                ),
                              ),
                              SizedBox(
                                height: 28.h,
                                width: 28.h,
                                child: IconButton(
                                  onPressed: () => _showDeleteDialog(
                                      context, complaint.id),
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                    Icons.delete_outline_rounded,
                                    color: appTheme.red500,
                                    size: 18.h,
                                  ),
                                  tooltip: 'Delete complaint',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String complaintId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Complaint'),
        content:
            const Text('Are you sure you want to delete this complaint?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Cancel',
              style: TextStyle(color: appTheme.black600),
            ),
          ),
          TextButton(
            onPressed: () {
              context
                  .read<TrackStatusBloc>()
                  .add(DeleteComplaintEvent(complaintId));
              Navigator.pop(dialogContext);
            },
            child: Text(
              'Delete',
              style: TextStyle(color: appTheme.red500),
            ),
          ),
        ],
      ),
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
