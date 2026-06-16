part of 'admin_dashboard_bloc.dart';

class AdminDashboardState extends Equatable {
  final AdminTab selectedTab;
  final bool isLoading;
  final String? errorMessage;
  final List<ComplaintModel> complaints;

  const AdminDashboardState({
    required this.selectedTab,
    this.isLoading = false,
    this.errorMessage,
    this.complaints = const [],
  });

  AdminDashboardState copyWith({
    AdminTab? selectedTab,
    bool? isLoading,
    String? errorMessage,
    List<ComplaintModel>? complaints,
  }) {
    return AdminDashboardState(
      selectedTab: selectedTab ?? this.selectedTab,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      complaints: complaints ?? this.complaints,
    );
  }

  @override
  List<Object?> get props => [
        selectedTab,
        isLoading,
        errorMessage,
        complaints,
      ];
}
