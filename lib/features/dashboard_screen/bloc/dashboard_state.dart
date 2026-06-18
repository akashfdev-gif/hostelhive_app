part of 'dashboard_bloc.dart';

enum DashboardTab { home, meals, complaints, payments, profile }

class DashboardState extends Equatable {
  const DashboardState({
    this.selectedTab = DashboardTab.home,
    this.isDarkModeEnabled = false,
    this.mealRating = 4,
    this.showAdminContactDialog = false,
  });

  final DashboardTab selectedTab;
  final bool isDarkModeEnabled;
  final int mealRating;

  /// One-shot flag to show admin contact dialog.
  final bool showAdminContactDialog;

  @override
  List<Object?> get props => [
        selectedTab,
        isDarkModeEnabled,
        mealRating,
        showAdminContactDialog,
      ];

  DashboardState copyWith({
    DashboardTab? selectedTab,
    bool? isDarkModeEnabled,
    int? mealRating,
    bool? showAdminContactDialog,
  }) {
    return DashboardState(
      selectedTab: selectedTab ?? this.selectedTab,
      isDarkModeEnabled: isDarkModeEnabled ?? this.isDarkModeEnabled,
      mealRating: mealRating ?? this.mealRating,
      showAdminContactDialog:
          showAdminContactDialog ?? this.showAdminContactDialog,
    );
  }
}
