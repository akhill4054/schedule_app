import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:lottie/lottie.dart';
import 'package:schedule_app/login/auth_bloc/auth_bloc.dart';
import 'package:schedule_app/login/auth_bloc/auth_state.dart';
import 'package:schedule_app/login/ui/login.dart';
import 'package:schedule_app/profile/ui/profile.dart';
import 'package:schedule_app/repositories/auth_repo.dart';
import 'package:schedule_app/settings/theme_cubit/theme_change_cubit.dart';
import 'package:schedule_app/settings/theme_cubit/theme_state.dart';

class LeftDrawerPage extends StatelessWidget {
  final GlobalKey<InnerDrawerState> _drawerKey;

  LeftDrawerPage({GlobalKey<InnerDrawerState> drawerKey})
      : _drawerKey = drawerKey {
    assert(_drawerKey != null);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => {
                _drawerKey.currentState.close(
                  direction: InnerDrawerDirection.start,
                )
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 8,
          ),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    if (state.status == AuthenticationStatus.authenticated) {
                      return DrawerProfilePage(user: state.user);
                    } else {
                      return DrawerLoginPage();
                    }
                  },
                ),
              ),
              Divider(
                height: 10,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Settings'),
                      onTap: () => {},
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.info_outline_rounded,
                      ),
                      title: Text('About'),
                      onTap: () => {},
                    ),
                    ListTile(
                      leading: Icon(Icons.help_outline_rounded),
                      title: Text('Help'),
                      onTap: () => {},
                    ),
                    ListTile(
                      leading: Icon(Icons.share_rounded),
                      title: Text('Share the app'),
                      onTap: () => {},
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          iconSize: 65,
                          onPressed: () {
                            BlocProvider.of<ThemeChangeCubit>(context)
                                .toggleDarkMode();
                          },
                          icon: BlocBuilder<ThemeChangeCubit, ThemeState>(
                            bloc: BlocProvider.of<ThemeChangeCubit>(context),
                            builder: (context, state) {
                              if (state is LightMode) {
                                return Lottie.asset(
                                  'assets/lottie/moon.json',
                                  width: 40,
                                );
                              } else {
                                return Lottie.asset(
                                  'assets/lottie/sun.json',
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
