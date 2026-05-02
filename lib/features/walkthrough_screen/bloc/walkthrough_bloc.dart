import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'walkthrough_event.dart';
part 'walkthrough_state.dart';

class WalkthroughBloc extends Bloc<WalkthroughEvent, WalkthroughState> {
  WalkthroughBloc() : super(const WalkthroughState()) {
    on<WalkthroughInitialEvent>(_onInitialize);
    on<WalkthroughGetStartedEvent>(_onGetStarted);
  }

  void _onInitialize(
    WalkthroughInitialEvent event,
    Emitter<WalkthroughState> emit,
  ) {
    // Initial logic if any
  }

  void _onGetStarted(
    WalkthroughGetStartedEvent event,
    Emitter<WalkthroughState> emit,
  ) {
    emit(state.copyWith(isNavigating: true));
  }
}
