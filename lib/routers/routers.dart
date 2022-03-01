// 路由配置文件
import 'package:blibli/model/video_model.dart';
import 'package:blibli/page/home_page.dart';
import 'package:blibli/page/video_detail_page.dart';
import 'package:flutter/material.dart';
import '../util/rotuter.dart';
import '../page/login_page.dart';
import '../page/register_page.dart';

final routers = {
  register_page: (context, {arguments}) => RegisterPage(),
  login_page: (context, {arguments}) => LoginPage(),
};

var onGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name;
  final Function pageContentBuilder = routers[name] as Function;
  print(pageContentBuilder);
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      print(settings.arguments);
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};

// class BiliRotueInfomationParser extends RouteInformationParser<BiliRouthPath> {
//   @override
//   Future<BiliRouthPath> parseRouteInformation(
//       RouteInformation routeInformation) async {
//     final url = Uri.parse(routeInformation.location ?? "");
//     print("url:${url.pathSegments}");
//     if (url.pathSegments.length == 0) {
//       return BiliRouthPath.home();
//     }
//     return BiliRouthPath.detail();
//   }
// }
