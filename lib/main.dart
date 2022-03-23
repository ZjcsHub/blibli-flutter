import 'package:blibli/generated/l10n.dart';
import 'package:blibli/http/core/hi_error.dart';
import 'package:blibli/http/dao/login_dao.dart';
import 'package:flutter/material.dart';
import 'navigator/hi_navigator.dart';
import 'routers/routers.dart';
import 'db/hi_cache.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'internationalization/Internation.dart';

void main() {
  runApp(const BiliApp());
}

class BiliApp extends StatefulWidget {
  const BiliApp({Key? key}) : super(key: key);

  @override
  _BiliAppState createState() => _BiliAppState();
}

class _BiliAppState extends State<BiliApp> {
  BiliRouterDelegate _routerDelegate = BiliRouterDelegate();

  // web需要使用的东西，可以屏蔽 PlatformRouteInformationProvider 是和 BiliRotueInfomationParser 配对存在的，可以同时删除
  // BiliRotueInfomationParser _routeInfomationParser =
  //     BiliRotueInfomationParser();

  @override
  Widget build(BuildContext context) {
    // 定义route
    return FutureBuilder<HiCache>(
      builder: (BuildContext context, AsyncSnapshot<HiCache> snapshot) {
        var widget = snapshot.connectionState == ConnectionState.done
            ? Router(
                routerDelegate: _routerDelegate,
                // routeInformationParser: _routeInfomationParser, // web 需要使用的东西
                // routeInformationProvider: PlatformRouteInformationProvider(
                //     initialRouteInformation: RouteInformation(
                //         location: BiliRouthPath.home().location)),
              )
            : Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );

        return MaterialApp(
          home: widget,
          theme: ThemeData(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Colors.white, // appbar背景颜色
                  onPrimary: Colors.black, // appbar文字颜色
                  brightness: Brightness.light,
                ),
          ),
          // 国际化
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            S.delegate
          ],
          supportedLocales: S.delegate.supportedLocales,
          localeResolutionCallback:
              (Locale? locale, Iterable<Locale> supportedLocales) {
            return locale;
          },
        );
      },
      // 进行初始化
      future: HiCache.preInit(),
    );
  }
}
