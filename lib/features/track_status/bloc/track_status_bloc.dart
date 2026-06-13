import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostel_hive/core/app_export.dart';

part 'track_status_event.dart';
part 'track_status_state.dart';

class TrackStatusBloc extends Bloc<TrackStatusEvent, TrackStatusState> {
  TrackStatusBloc() : super(const TrackStatusState()) {
    on<LoadComplaintStatusEvent>(_onLoadComplaintStatus);
  }

  void _onLoadComplaintStatus(
    LoadComplaintStatusEvent event,
    Emitter<TrackStatusState> emit,
  ) {
    // Mock data – replace with real API call
    emit(const TrackStatusState(
      complaintId: 'CMP-20260613-001',
      category: 'lbl_cat_wifi',
      title: 'lbl_complaint_title_sample',
      submittedOn: 'lbl_submitted_on_sample',
      priority: 'lbl_high',
      status: ComplaintStatus.inProgress,
      adminRemark: 'msg_admin_remark_sample',
      timeline: [
        ComplaintTimelineStep(
          titleKey: 'lbl_step_submitted',
          dateTime: 'lbl_step_submitted_time',
          stepStatus: StepStatus.completed,
        ),
        ComplaintTimelineStep(
          titleKey: 'lbl_step_received',
          dateTime: 'lbl_step_received_time',
          stepStatus: StepStatus.completed,
        ),
        ComplaintTimelineStep(
          titleKey: 'lbl_step_assigned',
          dateTime: 'lbl_step_assigned_time',
          stepStatus: StepStatus.active,
        ),
        ComplaintTimelineStep(
          titleKey: 'lbl_step_in_progress',
          dateTime: null,
          stepStatus: StepStatus.upcoming,
        ),
        ComplaintTimelineStep(
          titleKey: 'lbl_step_resolved',
          dateTime: null,
          stepStatus: StepStatus.upcoming,
        ),
      ],
    ));
  }
}
