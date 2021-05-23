import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:schedule_app/login/auth_bloc/auth_bloc.dart';
import 'package:schedule_app/login/auth_bloc/auth_event.dart';

class LogoutBottomSheetPage extends StatelessWidget {
  const LogoutBottomSheetPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32),
      child: Column(
        children: [
          Lottie.asset(
            'assets/lottie/logout.json',
            height: 235,
          ),
          Text(
            'Oh no! you\'re leaving...\nAre you sure?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Naah, just kidding',
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                elevation: 0,
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
              ),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(AuthenticationLogoutRequested());
              Navigator.pop(context);
            },
            child: Text(
              'Yes, Log me out!',
              style: TextStyle(fontSize: 20),
            ),
            style: OutlinedButton.styleFrom(
              shape: StadiumBorder(),
              elevation: 0,
              padding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
