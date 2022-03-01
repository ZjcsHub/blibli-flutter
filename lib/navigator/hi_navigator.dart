import 'package:blibli/http/dao/login_dao.dart';
import 'package:blibli/model/video_model.dart';
import 'package:blibli/page/home_page.dart';
import 'package:blibli/page/login_page.dart';
import 'package:blibli/page/register_page.dart';
import 'package:blibli/page/video_detail_page.dart';
import 'package:flutter/material.dart';

/// 创建页面
pageWrap(Widget child) {
  return MaterialPage(child: child, key: ValueKey(child.hashCode));
}

/// 获取routeStatus在页面堆栈中的位置
int getPageIndex(List<MaterialPage> pages, RouteStatus routeStatus) {
  for (int i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if (getStatus(page) == routeStatus) {
      return i;
    }
  }
  return -1;
}

/// 自定义路由封装，路由状态
enum RouteStatus { login, registration, home, detail, unknown }

/// 获取page对应的RouteStatus
RouteStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page.child is RegisterPage) {
    return RouteStatus.registration;
  } else if (page.child is HomePage) {
    return RouteStatus.home;
  } else if (page.child is VideoDetailPage) {
    return RouteStatus.detail;
  }
  return RouteStatus.unknown;
}

/// 路由信息
class RouteStatesInfo {
  final RouteStatus routeStatus;

  final Widget page;

  RouteStatesInfo(this.routeStatus, this.page);
}

/// 定义路由数据 path
class BiliRouthPath {
  final String location;

  BiliRouthPath.home() : location = "/";

  BiliRouthPath.detail() : location = "/detail";
}

class BiliRouterDelegate extends RouterDelegate<BiliRouthPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> navigationKey;

  List<MaterialPage> pages = [];
  VideoModel? videoModel;

  RouteStatus _routeStatus = RouteStatus.home;

  BiliRouterDelegate() : navigationKey = GlobalKey<NavigatorState>();

  BiliRouthPath? path;

  RouteStatus get routeStatus {
    print("routeStatus:$_routeStatus,hasLogin:$hasLogin");
    if (_routeStatus != RouteStatus.registration && !hasLogin) {
      return _routeStatus = RouteStatus.login;
    } else if (videoModel != null) {
      return _routeStatus = RouteStatus.detail;
    } else {
      return _routeStatus;
    }
  }

  bool get hasLogin => LoginDao.getBoardingPass() != null;
  @override
  Widget build(BuildContext context) {
    // 管理路由堆栈
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      tempPages = tempPages.sublist(0, index);
    }
    var page;
    print("_routeStatus:$_routeStatus");
    if (_routeStatus == RouteStatus.home) {
      // 跳转首页时将栈中其他页面进行出站
      pages.clear();
      page = pageWrap(HomePage(
        onJumpToDetail: (viewModel) {
          this.videoModel = viewModel;
          notifyListeners();
        },
      ));
    } else if (_routeStatus == RouteStatus.detail) {
      page = pageWrap(VideoDetailPage(videoModel!));
    } else if (_routeStatus == RouteStatus.registration) {
      page = pageWrap(RegisterPage(
        onJumpToLogin: () {
          _routeStatus = RouteStatus.login;
          notifyListeners();
        },
      ));
    } else if (_routeStatus == RouteStatus.login) {
      page = pageWrap(LoginPage());
    }
    tempPages = [...tempPages, page];
    pages = tempPages;
    print("build");
    // pages = [
    //   pageWrap(HomePage(
    //     onJumpToDetail: (viewModel) {
    //       this.videoModel = viewModel;
    //       notifyListeners();
    //     },
    //   )),
    //   if (videoModel != null) pageWrap(VideoDetailPage(videoModel!))
    // ];

    return Navigator(
      key: navigationKey,
      pages: pages,
      onPopPage: (route, result) {
        // 在这里可以控制是否可以返回
        if (!route.didPop(result)) {
          return false;
        }
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BiliRouthPath configuration) async {
    print("setNewRoutePath:${configuration.location}");
    this.path = configuration;
  }

  @override
  // TODO: implement navigatorKey
  GlobalKey<NavigatorState>? get navigatorKey => this.navigationKey;
}
