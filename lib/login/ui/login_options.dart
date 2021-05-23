import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:lottie/lottie.dart';
import 'package:schedule_app/login/auth_bloc/auth_bloc.dart';
import 'package:schedule_app/login/auth_bloc/auth_state.dart';
import 'package:schedule_app/login/login_bloc/login_bloc.dart';
import 'package:schedule_app/login/login_bloc/login_event.dart';
import 'package:schedule_app/login/login_bloc/login_state.dart';
import 'package:schedule_app/login/ui/login_progress.dart';
import 'package:schedule_app/repositories/auth_repo.dart';

class LoginOptionsPage extends StatelessWidget {
  const LoginOptionsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginIsInProgress) {
            return LoginProgressPage();
          } else {
            return buildIdealState(context);
          }
        },
      ),
    );
  }

  Widget buildIdealState(BuildContext context) => Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Lottie.asset(
                    'assets/lottie/login.json',
                    repeat: false,
                    width: 220,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8, bottom: 8),
                    child: Text('Choose an option sign in.',
                        style: TextStyle(fontSize: 16)),
                  ),
                  SignInButton(
                    Buttons.Google,
                    onPressed: () {
                      BlocProvider.of<LoginBloc>(context)
                          .add(LoginWithGoogleRequested());
                    },
                  ),
                  // ElevatedButton.icon(
                  //   onPressed: () {},
                  //   style: ElevatedButton.styleFrom(
                  //     primary: Theme.of(context).accentColor,
                  //   ),
                  //   icon: Icon(Icons.phone),
                  //   label: Text('Sign in with phone number'),
                  // ),
                ],
              ),
            ),
          ],
        ),
      );
}
