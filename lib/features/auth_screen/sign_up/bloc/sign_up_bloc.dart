import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState()) {
    on<SignUpEmailChanged>(_onEmailChanged);
    on<SignUpPasswordChanged>(_onPasswordChanged);
    on<SignUpConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SignUpTogglePasswordVisibilityEvent>(_onTogglePasswordVisibility);
    on<SignUpToggleConfirmPasswordVisibilityEvent>(_onToggleConfirmPasswordVisibility);
    on<SignUpSubmitEvent>(_onSubmit);
  }

  void _onEmailChanged(SignUpEmailChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(email: event.email, errorMessage: null));
  }

  void _onPasswordChanged(SignUpPasswordChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(password: event.password, errorMessage: null));
  }

  void _onConfirmPasswordChanged(
      SignUpConfirmPasswordChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(confirmPassword: event.confirmPassword, errorMessage: null));
  }

  void _onTogglePasswordVisibility(
    SignUpTogglePasswordVisibilityEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void _onToggleConfirmPasswordVisibility(
    SignUpToggleConfirmPasswordVisibilityEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword));
  }

  Future<void> _onSubmit(SignUpSubmitEvent event, Emitter<SignUpState> emit) async {
    if (!state.isFormValid) {
      emit(state.copyWith(
        errorMessage: state.password != state.confirmPassword
            ? 'lbl_password_not_match'
            : 'Please fill all fields',
      ));
      return;
    }
    emit(state.copyWith(isLoading: true, errorMessage: null));

    // Mock sign up
    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(isLoading: false, isSuccess: true));
  }
}
