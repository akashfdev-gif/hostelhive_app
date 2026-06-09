import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostel_hive/core/services/firebase_auth_service.dart';
import 'package:hostel_hive/core/utils/firebase_auth_error_utils.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({FirebaseAuthService? authService})
      : _authService = authService ?? FirebaseAuthService(),
        super(const SignInState()) {
    on<SignInEmailChanged>(_onEmailChanged);
    on<SignInPasswordChanged>(_onPasswordChanged);
    on<SignInTogglePasswordVisibilityEvent>(_onTogglePasswordVisibility);
    on<SignInSubmitEvent>(_onSubmit);
  }

  final FirebaseAuthService _authService;

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

  Future<void> _onSubmit(
    SignInSubmitEvent event,
    Emitter<SignInState> emit,
  ) async {
    if (!state.isFormValid) {
      emit(state.copyWith(errorMessage: 'msg_fill_all_fields'));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));

    try {
      await _authService.signInWithEmailAndPassword(
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
