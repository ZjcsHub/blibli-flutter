import 'package:blibli/db/hi_cache.dart';
import 'package:blibli/util/color.dart';
import 'package:blibli/util/view_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

extension ThemeModeExtension on ThemeMode {
  String get value => ['system', 'light', 'dark'][index];
}

class ThemeProvider extends ChangeNotifier {
  late ThemeMode _themeMode;

  Color? appbarBackColor;
  StatusStyle stateStyle = StatusStyle.Light;

  bool isDarkMode() {
    var isDark = false;
    if (_themeMode == ThemeMode.system) {
      // 系统darkmode
      var systemBrightness =
          SchedulerBinding.instance?.window.platformBrightness ==
              Brightness.dark;
      isDark = systemBrightness;
    } else {
      isDark = _themeMode == ThemeMode.dark;
    }
    return isDark;
  }

  var _platFormBrightness =
      SchedulerBinding.instance?.window.platformBrightness;

  void darModeChange() {
    if (_platFormBrightness !=
        SchedulerBinding.instance?.window.platformBrightness) {
      _platFormBrightness =
          SchedulerBinding.instance?.window.platformBrightness;
      notifyListeners();
    }
  }

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
    // _themeMode = ThemeMode.system;
    var isDark = isDarkMode();
    appbarBackColor = isDark ? HiColor.dark_bg : Colors.white;
    stateStyle = isDark ? StatusStyle.Light : StatusStyle.Dark;

    return _themeMode;
  }

  /// 设置主题
  setTheme(ThemeMode themeMode) {
    HiCache.getInstance().saveString("themeMode", themeMode.value);
    // appbarBackColor =
    //     themeMode == ThemeMode.dark ? HiColor.dark_bg : Colors.white;
    // stateStyle =
    //     themeMode == ThemeMode.dark ? StatusStyle.Light : StatusStyle.Dark;
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
