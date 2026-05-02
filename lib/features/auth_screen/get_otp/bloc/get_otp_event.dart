part of 'get_otp_bloc.dart';

abstract class GetOtpEvent {}

class GetOtpPhoneNumberChanged extends GetOtpEvent {
  final String phoneNumber;
  GetOtpPhoneNumberChanged({required this.phoneNumber});
}

class GetOtpCountryCodeChanged extends GetOtpEvent {
  final String countryCode;
  GetOtpCountryCodeChanged({required this.countryCode});
}

class GetOtpSubmitEvent extends GetOtpEvent {}
