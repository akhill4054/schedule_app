import 'package:flutter/cupertino.dart';

class LoginState {
  const LoginState();
}

// Third-party login states
class LoginIsInProgress extends LoginState {}

class LoginFailed extends LoginState {
  const LoginFailed({
    @required this.message,
  });

  final String message;
}

// Phone login states
class PhoneLoginState extends LoginState {
  final String phone;
  final String code;

  const PhoneLoginState({
    @required this.phone,
    @required this.code,
  });
}

class PhoneOTPVerificationIsInProgress extends PhoneLoginState {
  const PhoneOTPVerificationIsInProgress({
    @required String phone,
    @required String code,
  }) : super(code: code, phone: phone);
}

class PhoneOTPVerificationFailed extends PhoneLoginState {

  final String message;

  const PhoneOTPVerificationFailed({
    @required this.message,
    @required String phone,
    @required String code,
  }) : super(code: code, phone: phone);
}