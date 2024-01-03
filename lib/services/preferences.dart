import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences extends ChangeNotifier {
  late SharedPreferences _prefs;
  bool notifications = false;
  ThemeMode themeMode = ThemeMode.system;
  double timezoneFromUTC = 0;

  Future init() async {
    _prefs = await SharedPreferences.getInstance();
    syncWithPrefs();
  }

  void syncWithPrefs() {
    //notifications
    notifications = _prefs.getBool("notifications") ?? true;
    timezoneFromUTC = _prefs.getDouble("timezoneFromUTC") ??
        (DateTime.now().toLocal().hour - DateTime.now().toUtc().hour)
            .toDouble();
    themeMode = _prefs.getString("themeMode") == null
        ? ThemeMode.system
        : _prefs.getString("themeMode") == "light"
            ? ThemeMode.light
            : ThemeMode.dark;
    notifyListeners();
  }

  Future<void> setTimezoneFromUTC(double hoursFromUtc) async {
    await _prefs.setDouble("timezoneFromUTC", hoursFromUtc);
    syncWithPrefs();
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    String value = themeMode == ThemeMode.light ? "light" : "dark";
    await _prefs.setString("themeMode", value);
    syncWithPrefs();
  }

  Future<void> setNotifications(bool value) async {
    await _prefs.setBool("notifications", value);
    syncWithPrefs();
  }
}
