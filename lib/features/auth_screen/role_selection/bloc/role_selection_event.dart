part of 'role_selection_bloc.dart';

abstract class RoleSelectionEvent {
  const RoleSelectionEvent();
}

class RoleSelectedEvent extends RoleSelectionEvent {
  final String role;
  const RoleSelectedEvent(this.role);
}
