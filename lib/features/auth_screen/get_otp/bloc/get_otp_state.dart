part of 'get_otp_bloc.dart';

class GetOtpState extends Equatable {
  const GetOtpState({
    this.phoneNumber = '',
    this.selectedCountryCode = '+91',
  });

  final String phoneNumber;
  final String selectedCountryCode;

  bool get isPhoneNumberValid => phoneNumber.length == 10;

  @override
  List<Object?> get props => [phoneNumber, selectedCountryCode];

  GetOtpState copyWith({
    String? phoneNumber,
    String? selectedCountryCode,
  }) {
    return GetOtpState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      selectedCountryCode: selectedCountryCode ?? this.selectedCountryCode,
    );
  }
}
