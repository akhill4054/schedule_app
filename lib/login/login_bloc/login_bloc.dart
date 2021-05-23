import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_app/login/login_bloc/login_event.dart';
import 'package:schedule_app/login/login_bloc/login_state.dart';
import 'package:schedule_app/repositories/auth_repo.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc({@required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithGoogleRequested) {
      yield* _mapLoginWithGoogleToState();
    } else if (event is LoginWithGoogleRequested) {

    } else if (event is LoginWithPhoneRequested) {

    } else if (event is PhoneVerificationOTPSubmitted) {

    }
  }

  Stream<LoginState> _mapLoginWithGoogleToState() async* {
    yield LoginIsInProgress();
    try {
      await _authRepository.signInWithGoogle();
    } catch(err) {
      yield LoginFailed(message: 'Clould\'nt login.');
    }
  }
}
