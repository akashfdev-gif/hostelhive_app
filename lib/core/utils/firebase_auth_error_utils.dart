import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthErrorUtils {
  static String messageKeyFor(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return 'lbl_enter_valid_email';
      case 'user-disabled':
        return 'msg_account_disabled';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'msg_invalid_credentials';
      case 'email-already-in-use':
        return 'msg_email_already_in_use';
      case 'weak-password':
        return 'lbl_password_min_length';
      case 'network-request-failed':
        return 'msg_no_internet';
      case 'too-many-requests':
        return 'msg_too_many_requests';
      default:
        return 'msg_auth_failed';
    }
  }
}
