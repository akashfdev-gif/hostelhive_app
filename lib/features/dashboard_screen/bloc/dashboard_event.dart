part of 'dashboard_bloc.dart';

abstract class DashboardEvent {}

class DashboardInitialEvent extends DashboardEvent {}

class DashboardTabChangedEvent extends DashboardEvent {
  DashboardTabChangedEvent({required this.tab});

  final DashboardTab tab;
}

class DashboardDarkModeToggledEvent extends DashboardEvent {}

enum DashboardQuickAction {
  raiseComplaint,
  payFees,
  viewMenu,
  contactAdmin,
}

class DashboardQuickActionEvent extends DashboardEvent {
  DashboardQuickActionEvent({required this.action});

  final DashboardQuickAction action;
}

class DashboardMealRatingChangedEvent extends DashboardEvent {
  DashboardMealRatingChangedEvent({required this.rating});

  final int rating;
}
