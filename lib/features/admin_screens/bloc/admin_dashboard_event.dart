part of 'admin_dashboard_bloc.dart';

abstract class AdminDashboardEvent extends Equatable {
  const AdminDashboardEvent();

  @override
  List<Object?> get props => [];
}

class AdminDashboardInitialEvent extends AdminDashboardEvent {}

class AdminTabChangedEvent extends AdminDashboardEvent {
  final AdminTab tab;

  const AdminTabChangedEvent({required this.tab});

  @override
  List<Object?> get props => [tab];
}

enum AdminTab {
  home,
  complaints,
  meals,
  students,
  profile,
}

class UpdateComplaintStatusEvent extends AdminDashboardEvent {
  final String complaintId;
  final String newStatus;
  final String adminMessage;

  const UpdateComplaintStatusEvent({
    required this.complaintId,
    required this.newStatus,
    required this.adminMessage,
  });

  @override
  List<Object?> get props => [complaintId, newStatus, adminMessage];
}
