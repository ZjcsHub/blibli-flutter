import 'package:blibli/http/dao/login_dao.dart';
import 'package:blibli/page/login_page.dart';
import 'package:blibli/page/register_page.dart';
import 'package:blibli/page/video_detail_page.dart';
import 'package:blibli/util/toast.dart';
import 'package:flutter/material.dart';

import 'bottom_navigator.dart';

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
  } else if (page.child is BottomNavigator) {
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

  dynamic? _arguments;

  RouteStatus _routeStatus = RouteStatus.home;

  BiliRouterDelegate() : navigationKey = GlobalKey<NavigatorState>() {
    // 实现跳转逻辑
    HiNavigator.getInstance().registerRouteJump(
        RouteJumpListener(onJumpTo: (RouteStatus routeStatus, {dynamic? args}) {
      _routeStatus = routeStatus;
      _arguments = args;
      notifyListeners();
    }));
  }

  BiliRouthPath? path;

  RouteStatus get routeStatus {
    print("routeStatus:$_routeStatus,hasLogin:$hasLogin");
    if (_routeStatus != RouteStatus.registration && !hasLogin) {
      return _routeStatus = RouteStatus.login;
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
      page = pageWrap(BottomNavigator());
    } else if (_routeStatus == RouteStatus.detail) {
      page = pageWrap(VideoDetailPage(
        videoModel: this._arguments,
      ));
    } else if (_routeStatus == RouteStatus.registration) {
      page = pageWrap(RegisterPage());
    } else if (_routeStatus == RouteStatus.login) {
      page = pageWrap(LoginPage());
    }
    tempPages = [...tempPages, page];
    // 通知路由变化
    HiNavigator.getInstance().notify(tempPages, pages);

    pages = tempPages;

    return WillPopScope(
      onWillPop: () async {
        print("点击物理返回键");
        return await navigationKey.currentState!.maybePop();
      },
      child: Navigator(
        key: navigationKey,
        pages: pages,
        onPopPage: (route, result) {
          if (route.settings is MaterialPage) {
            // 登录页拦截
            if ((route.settings as MaterialPage).child is LoginPage) {
              if (!hasLogin) {
                showWarningToast("请先登录");
                return false;
              }
            }
          }

          // 在这里可以控制是否可以返回,执行返回操作
          if (!route.didPop(result)) {
            return false;
          }

          var tempPages = [...pages];
          pages.removeLast();
          // 通知路由变化
          HiNavigator.getInstance().notify(pages, tempPages);
          return true;
        },
      ),
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

class HiNavigator extends _RouteJumpListener {
  static HiNavigator? _instance;
  RouteJumpListener? _routerJump;

  RouteStatesInfo? _current;

  List<RouteChangeListener> _listtenners = [];

  // 首页底部的tab
  RouteStatesInfo? _bottomTab;

  static HiNavigator getInstance() {
    if (_instance == null) {
      _instance = HiNavigator();
    }
    return _instance!;
  }

  /// 首页底部tab切换监听
  void onBottomTabChange(int index, Widget page) {
    _bottomTab = RouteStatesInfo(RouteStatus.home, page);
    _notify(_bottomTab!);
  }

  /// 注册路由的跳转逻辑
  void registerRouteJump(RouteJumpListener routeJumpListener) {
    this._routerJump = routeJumpListener;
  }

  /// 监听路由页面跳转
  void addListener(RouteChangeListener listener) {
    if (!_listtenners.contains(listener)) {
      _listtenners.add(listener);
    }
  }

  /// 移除监听
  void removeListener(RouteChangeListener listener) {
    _listtenners.remove(listener);
  }

  @override
  void onJumpTo(RouteStatus routeStatus, {args}) {
    if (_routerJump != null) {
      if (_routerJump!.onJumpTo != null) {
        _routerJump!.onJumpTo!(routeStatus, args: args);
      }
    }
  }

  /// 通知路由堆栈的变化
  void notify(List<MaterialPage> currentPage, List<MaterialPage> prePages) {
    if (currentPage == prePages) return;

    /// 要打开的页面
    var current =
        RouteStatesInfo(getStatus(currentPage.last), currentPage.last.child);
    _notify(current);
  }

  void _notify(RouteStatesInfo current) {
    print("hi_navigator:current:${current.page}");
    print("hi_navigator:pre:${_current?.page}");

    if (current.page is BottomNavigator && _bottomTab != null) {
      current = _bottomTab!;
    }
    _listtenners.forEach((listener) {
      listener(current, _current);
    });

    _current = current;
  }
}

abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus routeStatus, {args});
}

typedef OnJumpTo = void Function(RouteStatus routeStatus, {dynamic? args});

class RouteJumpListener {
  final OnJumpTo? onJumpTo;
  RouteJumpListener({this.onJumpTo});
}

// 页面跳转监听
typedef RouteChangeListener(RouteStatesInfo current, RouteStatesInfo? pre);
