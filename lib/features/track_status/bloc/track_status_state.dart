part of 'track_status_bloc.dart';

enum ComplaintStatus { pending, inProgress, resolved, rejected }

class ComplaintTimelineStep extends Equatable {
  const ComplaintTimelineStep({
    required this.titleKey,
    required this.dateTime,
    required this.stepStatus,
  });

  final String titleKey;
  final String? dateTime;
  final StepStatus stepStatus;

  @override
  List<Object?> get props => [titleKey, dateTime, stepStatus];
}

enum StepStatus { completed, active, upcoming }

class TrackStatusState extends Equatable {
  const TrackStatusState({
    this.complaintId = 'CMP-20260613-001',
    this.category = 'lbl_cat_wifi',
    this.title = 'lbl_complaint_title_sample',
    this.submittedOn = 'lbl_submitted_on_sample',
    this.priority = 'lbl_high',
    this.status = ComplaintStatus.inProgress,
    this.adminRemark = 'msg_admin_remark_sample',
    this.timeline = const [],
  });

  final String complaintId;
  final String category;
  final String title;
  final String submittedOn;
  final String priority;
  final ComplaintStatus status;
  final String? adminRemark;
  final List<ComplaintTimelineStep> timeline;

  @override
  List<Object?> get props => [
        complaintId,
        category,
        title,
        submittedOn,
        priority,
        status,
        adminRemark,
        timeline,
      ];
}
