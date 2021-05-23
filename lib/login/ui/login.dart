import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_app/login/login_bloc/login_bloc.dart';
import 'package:schedule_app/repositories/auth_repo.dart';

import 'login_options.dart';

class DrawerLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).accentColor;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 165,
            margin: EdgeInsets.all(24),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: accentColor,
                width: 5,
              ),
            ),
            child: CircleAvatar(
              radius: 70,
              backgroundImage:
                  AssetImage('assets/image/profile_placeholder.jpg'),
            ),
          ),
          ElevatedButton(
            child: Text(
              'Log In',
              style: TextStyle(fontSize: 20),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                primary: accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                )),
            onPressed: () => {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return LoginBottomSheetPage();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
              )
            },
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: Text('Login to do more.'),
          ),
        ],
      ),
    );
  }
}

class LoginBottomSheetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authRepository: RepositoryProvider.of<AuthRepository>(context),
      ),
      child: LoginOptionsPage(),
    );
  }
}
