import 'package:flutter/material.dart';
import 'package:status_bar_control/status_bar_control.dart';

enum StatusStyle { Light, Dark }

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
      this.height = 64,
      this.child,
      this.showShadow = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _statusBarInit();
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
                    color: Colors.black12,
                    offset: Offset(0.0, 1.0), //阴影xy轴偏移量
                    blurRadius: 1.0, //阴影模糊程度
                    spreadRadius: 2.0 //阴影扩散程度
                    )
              ]
            : null,
      ),
      padding: EdgeInsets.only(top: top),
    );
  }

  _statusBarInit() async {
    // 沉浸式状态栏
    await StatusBarControl.setColor(this.color, animated: false);
    await StatusBarControl.setStyle(this.statusStyle == StatusStyle.Dark
        ? StatusBarStyle.DARK_CONTENT
        : StatusBarStyle.LIGHT_CONTENT);
  }
}
