import 'package:schedule_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static const _keyUser = "user";
  static const _keyIsDarkTheme = "isDarkTheme";

  static Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String userJson = prefs.getString(_keyUser);

    if (userJson?.isNotEmpty == true) {
      return User.fromJson(userJson);
    } else {
      return null;
    }
  }

  static void saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_keyUser, user.toJsonString());
  }

  static Future<bool> getIsDarkModeEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsDarkTheme) ?? false;
  }

  static Future<bool> setIsDarkModeEnabled(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_keyIsDarkTheme, isDarkMode);
  }

  static Future<void> clearSensitivePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_keyUser, '');
  }
}