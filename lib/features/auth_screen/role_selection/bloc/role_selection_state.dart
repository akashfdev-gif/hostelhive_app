part of 'role_selection_bloc.dart';

class RoleSelectionState extends Equatable {
  final String? selectedRole;
  final bool isLoading;

  const RoleSelectionState({
    this.selectedRole,
    this.isLoading = false,
  });

  RoleSelectionState copyWith({
    String? selectedRole,
    bool? isLoading,
  }) {
    return RoleSelectionState(
      selectedRole: selectedRole ?? this.selectedRole,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [selectedRole, isLoading];
}
