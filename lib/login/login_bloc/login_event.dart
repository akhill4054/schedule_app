import 'package:flutter/cupertino.dart';
import 'package:schedule_app/login/login_bloc/login_state.dart';

// Third-party login events
abstract class LoginEvent {
  const LoginEvent();
}

class LoginWithGoogleRequested extends LoginEvent {}

// Phone login events
class LoginWithPhoneRequested extends LoginState {
  const LoginWithPhoneRequested({
    @required this.code,
    @required this.phone,
  });

  final String code;
  final String phone;
}

class PhoneVerificationOTPSubmitted extends LoginEvent {
  const PhoneVerificationOTPSubmitted({@required this.otp});

  final String otp;
}
