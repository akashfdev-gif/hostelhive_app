part of 'verify_otp_bloc.dart';

class VerifyOtpState extends Equatable {
  const VerifyOtpState({
    this.otpCode = '',
    this.timerDuration = 30,
  });

  final String otpCode;
  final int timerDuration;

  bool get isOtpValid => otpCode.length == 6;

  @override
  List<Object?> get props => [otpCode, timerDuration];

  VerifyOtpState copyWith({
    String? otpCode,
    int? timerDuration,
  }) {
    return VerifyOtpState(
      otpCode: otpCode ?? this.otpCode,
      timerDuration: timerDuration ?? this.timerDuration,
    );
  }
}
