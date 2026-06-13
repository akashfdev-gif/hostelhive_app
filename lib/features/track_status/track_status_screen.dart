import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/track_status/bloc/track_status_bloc.dart';
import 'package:hostel_hive/features/track_status/widgets/complaint_info_card.dart';
import 'package:hostel_hive/features/track_status/widgets/status_badge.dart';
import 'package:hostel_hive/features/track_status/widgets/progress_timeline.dart';
import 'package:hostel_hive/features/track_status/widgets/admin_remarks_card.dart';

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
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16.h,
              children: [
                ComplaintInfoCard(state: state),
                StatusBadge(status: state.status),
                ProgressTimeline(steps: state.timeline),
                AdminRemarksCard(remark: state.adminRemark),
              ],
            ),
          );
        },
      ),
    );
  }
}
