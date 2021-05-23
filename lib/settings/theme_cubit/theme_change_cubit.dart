import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_app/settings/theme_cubit/theme_state.dart';
import 'package:schedule_app/utils/prefs.dart';

class ThemeChangeCubit extends Cubit<ThemeState> {
  ThemeChangeCubit() : super(ThemeState()) {
    _checkForCurrentTheme();
  }

  _checkForCurrentTheme() async {
    final bool isDarkMode = await PreferenceManager.getIsDarkModeEnabled();
    _setThemeState(isDarkMode);
  }

  toggleDarkMode() async {
    bool isDarkMode = await PreferenceManager.getIsDarkModeEnabled();
    // Toggle theme
    isDarkMode = !isDarkMode;
    // Update prefs and change the state
    PreferenceManager.setIsDarkModeEnabled(isDarkMode);
    _setThemeState(isDarkMode);
  }

  _setThemeState(bool isDarkMode) {
    if (isDarkMode) {
      // Switch to light mode
      emit(DarkMode());
    } else {
      // Switch to dark mode
      emit(LightMode());
    }
  }
}
