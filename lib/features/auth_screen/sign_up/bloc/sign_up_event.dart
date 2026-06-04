part of 'sign_up_bloc.dart';

abstract class SignUpEvent {
  const SignUpEvent();
}

class SignUpEmailChanged extends SignUpEvent {
  final String email;
  const SignUpEmailChanged(this.email);
}

class SignUpPasswordChanged extends SignUpEvent {
  final String password;
  const SignUpPasswordChanged(this.password);
}

class SignUpConfirmPasswordChanged extends SignUpEvent {
  final String confirmPassword;
  const SignUpConfirmPasswordChanged(this.confirmPassword);
}

class SignUpTogglePasswordVisibilityEvent extends SignUpEvent {
  const SignUpTogglePasswordVisibilityEvent();
}

class SignUpToggleConfirmPasswordVisibilityEvent extends SignUpEvent {
  const SignUpToggleConfirmPasswordVisibilityEvent();
}

class SignUpSubmitEvent extends SignUpEvent {
  const SignUpSubmitEvent();
}
