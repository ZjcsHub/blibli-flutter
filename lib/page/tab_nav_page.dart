import 'package:flutter/material.dart';

// 自定义tab
class NewsTab {
  String text;
  String tab;
  NewsTab(this.text, this.tab);
}

class TabNavigation extends StatelessWidget {
  final NewsTab? currentTab;
  final ValueChanged<NewsTab>? onSelectTab; //这个参数比较关键，仔细理解下，省了setState()调用的环节

  final List<NewsTab> tabLists;

  const TabNavigation(this.tabLists,
      {Key? key, this.currentTab, this.onSelectTab})
      : super(key: key);

  //定义tab被选中和没被选中的颜色样式
  Color _colorTabMatching({NewsTab? item}) {
    return currentTab == item ? Colors.black : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        children: tabLists.map((item) {
      return GestureDetector(
        // 手势监听控件
        child: Container(
          padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Text(
            item.text,
            style: TextStyle(color: _colorTabMatching(item: item)),
          ),
        ),
        onTap: () {
          if (onSelectTab != null) {
            onSelectTab!(item);
          }
        },
      );
    }).toList());
  }
}
