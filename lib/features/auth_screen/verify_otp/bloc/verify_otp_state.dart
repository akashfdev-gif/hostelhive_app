part of 'verify_otp_bloc.dart';

class VerifyOtpState extends Equatable {
  const VerifyOtpState({
    this.otpCode = '',
    this.timerDuration = 30,
    this.isLoading = false,
    this.isSuccess = false,
  });

  final String otpCode;
  final int timerDuration;
  final bool isLoading;
  final bool isSuccess;

  bool get isOtpValid => otpCode.length == 6;

  @override
  List<Object?> get props => [otpCode, timerDuration, isLoading, isSuccess];

  VerifyOtpState copyWith({
    String? otpCode,
    int? timerDuration,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return VerifyOtpState(
      otpCode: otpCode ?? this.otpCode,
      timerDuration: timerDuration ?? this.timerDuration,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
