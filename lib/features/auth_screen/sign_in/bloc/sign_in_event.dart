part of 'sign_in_bloc.dart';

abstract class SignInEvent {
  const SignInEvent();
}

class SignInEmailChanged extends SignInEvent {
  final String email;
  const SignInEmailChanged(this.email);
}

class SignInPasswordChanged extends SignInEvent {
  final String password;
  const SignInPasswordChanged(this.password);
}

class SignInTogglePasswordVisibilityEvent extends SignInEvent {
  const SignInTogglePasswordVisibilityEvent();
}

class SignInSubmitEvent extends SignInEvent {
  const SignInSubmitEvent();
}
