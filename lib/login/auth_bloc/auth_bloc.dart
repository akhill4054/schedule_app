import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_app/login/auth_bloc/auth_event.dart';
import 'package:schedule_app/login/auth_bloc/auth_state.dart';
import 'package:schedule_app/repositories/auth_repo.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository _authRepository;

  StreamSubscription<AuthenticationStatus> _authStatusSubscription;

  AuthenticationBloc({
    @required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(AuthenticationState.unknown()) {
    _authStatusSubscription = _authRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthStatusChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      await _authRepository.signOut();
      yield AuthenticationState.unauthenticated();
    }
  }

  Future<AuthenticationState> _mapAuthStatusChangedToState(
    AuthenticationStatusChanged event,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return AuthenticationState.unauthenticated();
      case AuthenticationStatus.authenticated:
        final user = await _authRepository.tryToGetUser();
        return (user != null)
            ? AuthenticationState.authenticated(user)
            : const AuthenticationState.unauthenticated();
      default:
        return AuthenticationState.unknown();
    }
  }

  @override
  Future<Function> close() {
    _authRepository.dispose();
    _authStatusSubscription.cancel();
    return super.close();
  }
}
