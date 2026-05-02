import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_otp_event.dart';
part 'get_otp_state.dart';

class GetOtpBloc extends Bloc<GetOtpEvent, GetOtpState> {
  GetOtpBloc() : super(const GetOtpState()) {
    on<GetOtpPhoneNumberChanged>(_onPhoneNumberChanged);
    on<GetOtpCountryCodeChanged>(_onCountryCodeChanged);
    on<GetOtpSubmitEvent>(_onSubmit);
  }

  void _onPhoneNumberChanged(
    GetOtpPhoneNumberChanged event,
    Emitter<GetOtpState> emit,
  ) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  void _onCountryCodeChanged(
    GetOtpCountryCodeChanged event,
    Emitter<GetOtpState> emit,
  ) {
    emit(state.copyWith(selectedCountryCode: event.countryCode));
  }

  void _onSubmit(
    GetOtpSubmitEvent event,
    Emitter<GetOtpState> emit,
  ) {
    if (state.isPhoneNumberValid) {
      // Add logic here to submit phone number and request OTP
    }
  }
}
