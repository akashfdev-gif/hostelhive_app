part of 'get_otp_bloc.dart';

class GetOtpState extends Equatable {
  const GetOtpState({
    this.phoneNumber = '',
    this.selectedCountryCode = '+91',
    this.isLoading = false,
    this.isSuccess = false,
  });

  final String phoneNumber;
  final String selectedCountryCode;
  final bool isLoading;
  final bool isSuccess;

  bool get isPhoneNumberValid => phoneNumber.length == 10;

  @override
  List<Object?> get props => [phoneNumber, selectedCountryCode, isLoading, isSuccess];

  GetOtpState copyWith({
    String? phoneNumber,
    String? selectedCountryCode,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return GetOtpState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      selectedCountryCode: selectedCountryCode ?? this.selectedCountryCode,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
