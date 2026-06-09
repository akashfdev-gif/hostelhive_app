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
