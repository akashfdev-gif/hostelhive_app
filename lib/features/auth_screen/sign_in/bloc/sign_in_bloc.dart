import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(const SignInState()) {
    on<SignInEmailChanged>(_onEmailChanged);
    on<SignInPasswordChanged>(_onPasswordChanged);
    on<SignInTogglePasswordVisibilityEvent>(_onTogglePasswordVisibility);
    on<SignInSubmitEvent>(_onSubmit);
  }

  void _onEmailChanged(SignInEmailChanged event, Emitter<SignInState> emit) {
    emit(state.copyWith(email: event.email, errorMessage: null));
  }

  void _onPasswordChanged(SignInPasswordChanged event, Emitter<SignInState> emit) {
    emit(state.copyWith(password: event.password, errorMessage: null));
  }

  void _onTogglePasswordVisibility(
    SignInTogglePasswordVisibilityEvent event,
    Emitter<SignInState> emit,
  ) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  Future<void> _onSubmit(SignInSubmitEvent event, Emitter<SignInState> emit) async {
    if (!state.isFormValid) {
      emit(state.copyWith(
        errorMessage: 'Please fill all fields',
      ));
      return;
    }
    emit(state.copyWith(isLoading: true, errorMessage: null));

    // Mock authentication
    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(isLoading: false, isSuccess: true));
  }
}
