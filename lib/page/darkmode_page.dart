import 'package:blibli/internationalization/Internation.dart';
import 'package:blibli/util/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';

/// 夜间模式页面

class DarkModePage extends StatefulWidget {
  const DarkModePage({Key? key}) : super(key: key);

  @override
  State<DarkModePage> createState() => _DarkModePageState();
}

class _DarkModePageState extends State<DarkModePage> {
  static const _Items = [
    {
      "name": "跟随系统",
      "mode": ThemeMode.system,
    },
    {
      "name": "开启",
      "mode": ThemeMode.dark,
    },
    {
      "name": "关闭",
      "mode": ThemeMode.light,
    }
  ];

  var _currentTheme;

  @override
  void initState() {
    super.initState();
    var themeMode = context.read<ThemeProvider>().getThemeMode();
    _currentTheme =
        _Items.firstWhere((element) => element["mode"] == themeMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Internation.getInstance().ThemeTitle(context)),
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return _item(index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
          itemCount: _Items.length),
    );
  }

  Widget _item(int index) {
    var theme = _Items[index];

    return InkWell(
      onTap: () {
        _switchTheme(index);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: Text(theme["name"] as String),
            ),
            Opacity(
              opacity: _currentTheme == theme ? 1 : 0,
              child: Icon(
                Icons.done,
                color: primary,
              ),
            )
          ],
        ),
      ),
    );
  }

  _switchTheme(int index) {
    var theme = _Items[index];
    var changeMode = theme["mode"] as ThemeMode;
    context.read<ThemeProvider>().setTheme(changeMode);
    setState(() {
      _currentTheme = theme;
    });
  }
}
