import 'package:blibli/navigator/hi_navigator.dart';
import 'package:blibli/util/color.dart';
import 'package:flutter/material.dart';

import '../page/favorite_page.dart';
import '../page/home_page.dart';
import '../page/profice_page.dart';
import '../page/ranking_page.dart';

/// 底部导航
class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final _defaultColor = Colors.grey;
  final _activColor = primary;
  int _currentIndex = 0;

  static int initalPage = 0;

  final PageController _controller = PageController(initialPage: initalPage);

  List<Widget> _pages = [];
  bool _hasBuild = false;
  @override
  Widget build(BuildContext context) {
    _pages = [HomePage(), RankingPage(), FavoritePage(), ProficePage()];
    if (!_hasBuild) {
      // 页面第一次打开时通知打开的是哪个tab
      HiNavigator.getInstance()
          .onBottomTabChange(initalPage, _pages[initalPage]);
      _hasBuild = true;
    }

    return Scaffold(
      body: PageView(
        controller: _controller,
        children: _pages,
        onPageChanged: (index) => _onJumpTo(index, pageChange: true),
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => _onJumpTo(index),
        selectedItemColor: _activColor,
        items: [
          _bottomItem("首页", Icons.home, 0),
          _bottomItem("排行", Icons.local_fire_department, 1),
          _bottomItem("收藏", Icons.favorite, 2),
          _bottomItem("我的", Icons.live_tv, 3)
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  _bottomItem(String name, IconData icon, int i) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: _defaultColor,
        ),
        activeIcon: Icon(
          icon,
          color: _activColor,
        ),
        label: name);
  }

  _onJumpTo(int index, {pageChange = false}) {
    // pageview 展示对应tap
    if (!pageChange) {
      _controller.jumpToPage(index);
    } else {
      HiNavigator.getInstance().onBottomTabChange(index, _pages[index]);
    }

    setState(() {
      // 控制底部选中
      _currentIndex = index;
    });
  }
}
