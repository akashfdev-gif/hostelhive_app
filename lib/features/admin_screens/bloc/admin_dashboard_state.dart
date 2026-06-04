import 'package:equatable/equatable.dart';
import 'admin_dashboard_event.dart';

class AdminDashboardState extends Equatable {
  final AdminTab selectedTab;
  final bool isLoading;
  final String? errorMessage;

  const AdminDashboardState({
    required this.selectedTab,
    this.isLoading = false,
    this.errorMessage,
  });

  AdminDashboardState copyWith({
    AdminTab? selectedTab,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AdminDashboardState(
      selectedTab: selectedTab ?? this.selectedTab,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        selectedTab,
        isLoading,
        errorMessage,
      ];
}
