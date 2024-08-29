import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yolo/theme.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeData _selectedTheme;
  late SharedPreferences pref;
  ThemeProvider({bool isDark = false}) {
    _selectedTheme = isDark ? darkTheme : lightTheme;
  }

  ThemeData get getTheme => _selectedTheme;

  Future<void> changeTheme() async {
    pref = await SharedPreferences.getInstance();

    if (_selectedTheme == darkTheme) {
      _selectedTheme = lightTheme;
      await pref.setBool("isDark", false);
    } else {
      _selectedTheme = darkTheme;
      await pref.setBool("isDark", true);
    }
    notifyListeners();
  }
}
