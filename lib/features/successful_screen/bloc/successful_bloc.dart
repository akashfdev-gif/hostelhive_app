import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'successful_event.dart';
part 'successful_state.dart';

class SuccessfulBloc extends Bloc<SuccessfulEvent, SuccessfulState> {
  SuccessfulBloc() : super(const SuccessfulState()) {
    on<SuccessfulContinueEvent>(_onContinue);
  }

  void _onContinue(
    SuccessfulContinueEvent event,
    Emitter<SuccessfulState> emit,
  ) {
    // Logic for continue action if needed
  }
}
