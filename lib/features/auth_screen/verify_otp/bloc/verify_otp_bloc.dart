import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verify_otp_event.dart';
part 'verify_otp_state.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  StreamSubscription<int>? _timerSubscription;
  
  VerifyOtpBloc() : super(const VerifyOtpState()) {
    on<VerifyOtpCodeChanged>(_onOtpCodeChanged);
    on<VerifyOtpSubmitEvent>(_onSubmit);
    on<VerifyOtpResendEvent>(_onResend);
    on<VerifyOtpTimerTicked>(_onTimerTicked);
    
    _startTimer();
  }

  void _onOtpCodeChanged(
    VerifyOtpCodeChanged event,
    Emitter<VerifyOtpState> emit,
  ) {
    emit(state.copyWith(otpCode: event.otpCode));
  }

  Future<void> _onSubmit(
    VerifyOtpSubmitEvent event,
    Emitter<VerifyOtpState> emit,
  ) async {
    if (state.isOtpValid) {
      emit(state.copyWith(isLoading: true));
      // Simulate network request
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(isLoading: false, isSuccess: true));
    }
  }

  void _onResend(
    VerifyOtpResendEvent event,
    Emitter<VerifyOtpState> emit,
  ) {
    emit(state.copyWith(timerDuration: 30));
    _startTimer();
  }

  void _onTimerTicked(
    VerifyOtpTimerTicked event,
    Emitter<VerifyOtpState> emit,
  ) {
    emit(state.copyWith(timerDuration: event.duration));
  }

  void _startTimer() {
    _timerSubscription?.cancel();
    _timerSubscription = Stream.periodic(const Duration(seconds: 1), (x) => 30 - x - 1)
        .take(30)
        .listen((duration) => add(VerifyOtpTimerTicked(duration: duration)));
  }
  
  @override
  Future<void> close() {
    _timerSubscription?.cancel();
    return super.close();
  }
}
