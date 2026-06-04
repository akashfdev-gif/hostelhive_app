import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'role_selection_event.dart';
part 'role_selection_state.dart';

class RoleSelectionBloc extends Bloc<RoleSelectionEvent, RoleSelectionState> {
  RoleSelectionBloc() : super(const RoleSelectionState()) {
    on<RoleSelectedEvent>(_onRoleSelected);
  }

  void _onRoleSelected(RoleSelectedEvent event, Emitter<RoleSelectionState> emit) {
    emit(state.copyWith(selectedRole: event.role));
  }
}
