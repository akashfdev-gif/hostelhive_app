import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardState()) {
    on<DashboardInitialEvent>(_onInitialize);
    on<DashboardTabChangedEvent>(_onTabChanged);
    on<DashboardDarkModeToggledEvent>(_onDarkModeToggled);
    on<DashboardQuickActionEvent>(_onQuickAction);
    on<DashboardMealRatingChangedEvent>(_onMealRatingChanged);
  }

  void _onInitialize(
    DashboardInitialEvent event,
    Emitter<DashboardState> emit,
  ) {
    emit(state);
  }

  void _onTabChanged(
    DashboardTabChangedEvent event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.copyWith(selectedTab: event.tab));
  }

  void _onDarkModeToggled(
    DashboardDarkModeToggledEvent event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.copyWith(isDarkModeEnabled: !state.isDarkModeEnabled));
  }

  void _onQuickAction(
    DashboardQuickActionEvent event,
    Emitter<DashboardState> emit,
  ) {
    switch (event.action) {
      case DashboardQuickAction.raiseComplaint:
        emit(state.copyWith(selectedTab: DashboardTab.complaints));
      case DashboardQuickAction.payFees:
        emit(state.copyWith(selectedTab: DashboardTab.payments));
      case DashboardQuickAction.viewMenu:
        emit(state.copyWith(selectedTab: DashboardTab.meals));
      case DashboardQuickAction.contactAdmin:
        emit(
          state.copyWith(
            selectedTab: DashboardTab.profile,
            showAdminContactDialog: true,
          ),
        );
    }
  }

  void _onMealRatingChanged(
    DashboardMealRatingChangedEvent event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.copyWith(mealRating: event.rating));
  }
}
