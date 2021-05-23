import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_app/login/auth_bloc/auth_bloc.dart';
import 'package:schedule_app/repositories/auth_repo.dart';
import 'package:schedule_app/settings/theme_cubit/theme_change_cubit.dart';
import 'package:schedule_app/settings/theme_cubit/theme_state.dart';
import 'package:schedule_app/theme.dart';

import 'home/ui/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(App());
}

class App extends StatelessWidget {
  final _authRepository = AuthRepository();

  final _themeCubit = ThemeChangeCubit();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthenticationBloc(
              authRepository: _authRepository,
            ),
          ),
          BlocProvider(
            create: (_) => _themeCubit,
          ),
        ],
        child: BlocBuilder<ThemeChangeCubit, ThemeState>(
          bloc: _themeCubit,
          builder: (context, state) => MaterialApp(
            home: HomePage(),
            theme: (state is LightMode)
                ? AppTheme().getLightTheme()
                : AppTheme().getDarkTheme(),
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}
