import 'package:flutter/material.dart';

class HiRefresh extends StatelessWidget {
  final Widget child;
  final ValueChanged<Future>? valueChanged;
  const HiRefresh(this.child, {Key? key, this.valueChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _onRefresh, //下拉刷新回调
        displacement: 40, //指示器显示时距顶部位置
        color: Colors.red, //指示器颜色，默认ThemeData.accentColor
        backgroundColor: Colors.blue, //指示器背景颜色，默认ThemeData.canvasColor
        notificationPredicate:
            defaultScrollNotificationPredicate, //是否应处理滚动通知的检查（是否通知下拉刷新动作）
        child: child);
  }

  Future _onRefresh() {
    var d = Future.delayed(Duration(seconds: 2));
    if (valueChanged != null) {
      valueChanged!(d);
    }
    return d;
  }
}
