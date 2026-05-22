part of 'dashboard_bloc.dart';

enum DashboardTab { home, meals, complaints, payments, profile }

class DashboardState extends Equatable {
  const DashboardState({
    this.selectedTab = DashboardTab.home,
    this.isDarkModeEnabled = false,
    this.mealRating = 4,
  });

  final DashboardTab selectedTab;
  final bool isDarkModeEnabled;
  final int mealRating;

  @override
  List<Object?> get props => [selectedTab, isDarkModeEnabled, mealRating];

  DashboardState copyWith({
    DashboardTab? selectedTab,
    bool? isDarkModeEnabled,
    int? mealRating,
  }) {
    return DashboardState(
      selectedTab: selectedTab ?? this.selectedTab,
      isDarkModeEnabled: isDarkModeEnabled ?? this.isDarkModeEnabled,
      mealRating: mealRating ?? this.mealRating,
    );
  }
}
