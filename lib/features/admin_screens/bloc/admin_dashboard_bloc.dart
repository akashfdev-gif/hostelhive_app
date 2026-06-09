import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_dashboard_event.dart';
part 'admin_dashboard_state.dart';

class AdminDashboardBloc extends Bloc<AdminDashboardEvent, AdminDashboardState> {
  AdminDashboardBloc()
      : super(const AdminDashboardState(selectedTab: AdminTab.home)) {
    on<AdminDashboardInitialEvent>(_onInitialEvent);
    on<AdminTabChangedEvent>(_onTabChangedEvent);
  }

  void _onInitialEvent(
    AdminDashboardInitialEvent event,
    Emitter<AdminDashboardState> emit,
  ) {
    // TODO: Implement initial loading logic
  }

  void _onTabChangedEvent(
    AdminTabChangedEvent event,
    Emitter<AdminDashboardState> emit,
  ) {
    emit(state.copyWith(selectedTab: event.tab));
  }
}
