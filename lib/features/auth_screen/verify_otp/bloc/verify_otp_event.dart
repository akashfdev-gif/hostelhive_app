part of 'verify_otp_bloc.dart';

abstract class VerifyOtpEvent {}

class VerifyOtpCodeChanged extends VerifyOtpEvent {
  final String otpCode;
  VerifyOtpCodeChanged({required this.otpCode});
}

class VerifyOtpSubmitEvent extends VerifyOtpEvent {}

class VerifyOtpResendEvent extends VerifyOtpEvent {}

class VerifyOtpTimerTicked extends VerifyOtpEvent {
  final int duration;
  VerifyOtpTimerTicked({required this.duration});
}
