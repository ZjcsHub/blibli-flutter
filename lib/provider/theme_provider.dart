import 'package:blibli/db/hi_cache.dart';
import 'package:blibli/util/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension ThemeModeExtension on ThemeMode {
  String get value => ['system', 'light', 'dark'][index];
}

class ThemeProvider extends ChangeNotifier {
  late ThemeMode _themeMode;

  /// 获取主题
  ThemeMode getThemeMode() {
    String theme = HiCache.getInstance().getString("themeMode");
    switch (theme) {
      case 'dark':
        _themeMode = ThemeMode.dark;
        break;
      case 'system':
        _themeMode = ThemeMode.system;
        break;
      default:
        _themeMode = ThemeMode.light;
        break;
    }
    return _themeMode;
  }

  /// 设置主题
  setTheme(ThemeMode themeMode) {
    HiCache.getInstance().saveString("themeMode", themeMode.value);
    notifyListeners();
  }

  ThemeData getTheme(BuildContext context, {bool isDarkMode = false}) {
    print("isDarkMode:$isDarkMode");
    var themeData = ThemeData(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      errorColor: isDarkMode ? HiColor.dark_red : HiColor.red,
      primaryColor: isDarkMode ? HiColor.dark_bg : Colors.white,
      // primaryColorDark: HiColor.dark_bg,
      // primaryColorLight: Colors.white,
      // tab 指示器颜色
      indicatorColor: isDarkMode ? primary : Colors.white,
      // 页面背景色
      scaffoldBackgroundColor: isDarkMode ? HiColor.dark_bg : Colors.white,
      appBarTheme: AppBarTheme.of(context).copyWith(
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
          backgroundColor: isDarkMode ? HiColor.dark_bg : Colors.white,
          foregroundColor: isDarkMode ? Colors.white : Colors.black),
      // colorScheme: ColorScheme.fromSwatch().copyWith(
      //     secondary: isDarkMode ? primary : Colors.white,
      //     brightness: isDarkMode ? Brightness.dark : Brightness.light,
      //     primary: isDarkMode ? HiColor.dark_bg : Colors.white,
      //     onPrimary: isDarkMode ? Colors.white : Colors.black
      // )
    );
    return themeData;
  }
}
