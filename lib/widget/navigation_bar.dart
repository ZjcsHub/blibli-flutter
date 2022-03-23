import 'package:flutter/material.dart';
import 'package:status_bar_control/status_bar_control.dart';
import '../util/view_util.dart';

class NavigationBar extends StatelessWidget {
  final StatusStyle statusStyle;

  final Color color;

  final double height;
  final Widget? child;
  final bool showShadow;
  const NavigationBar(
      {Key? key,
      this.statusStyle = StatusStyle.Dark,
      this.color = Colors.white,
      this.height = 56,
      this.child,
      this.showShadow = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    setStatusBar(color, statusStyle);
    // 状态栏高度
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: this.height + top,
      child: this.child,
      decoration: BoxDecoration(
        color: this.color,
        boxShadow: this.showShadow
            ? [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 1.0), //阴影xy轴偏移量
                    blurRadius: 5.0, //阴影模糊程度
                    spreadRadius: 2.0 //阴影扩散程度
                    )
              ]
            : null,
      ),
      padding: EdgeInsets.only(top: top),
    );
  }
}
