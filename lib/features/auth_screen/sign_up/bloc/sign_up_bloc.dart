import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostel_hive/core/services/firebase_auth_service.dart';
import 'package:hostel_hive/core/utils/firebase_auth_error_utils.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({FirebaseAuthService? authService})
      : _authService = authService ?? FirebaseAuthService(),
        super(const SignUpState()) {
    on<SignUpEmailChanged>(_onEmailChanged);
    on<SignUpPasswordChanged>(_onPasswordChanged);
    on<SignUpConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SignUpTogglePasswordVisibilityEvent>(_onTogglePasswordVisibility);
    on<SignUpToggleConfirmPasswordVisibilityEvent>(
      _onToggleConfirmPasswordVisibility,
    );
    on<SignUpSubmitEvent>(_onSubmit);
  }

  final FirebaseAuthService _authService;

  void _onEmailChanged(SignUpEmailChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(email: event.email, errorMessage: null));
  }

  void _onPasswordChanged(SignUpPasswordChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(password: event.password, errorMessage: null));
  }

  void _onConfirmPasswordChanged(
    SignUpConfirmPasswordChanged event,
    Emitter<SignUpState> emit,
  ) {
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
    if (state.password.length < 6) {
      emit(state.copyWith(errorMessage: 'lbl_password_min_length'));
      return;
    }

    if (!state.isFormValid) {
      emit(
        state.copyWith(
          errorMessage: state.password != state.confirmPassword
              ? 'lbl_password_not_match'
              : 'msg_fill_all_fields',
        ),
      );
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));

    try {
      await _authService.signUpWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: FirebaseAuthErrorUtils.messageKeyFor(e),
        ),
      );
    } catch (_) {
      emit(state.copyWith(isLoading: false, errorMessage: 'msg_auth_failed'));
    }
  }
}
