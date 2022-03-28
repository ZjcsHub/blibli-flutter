import 'package:blibli/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:status_bar_control/status_bar_control.dart';
import '../util/view_util.dart';
import 'package:provider/provider.dart';
//
// class NavigationBar extends StatefulWidget {
//   final StatusStyle? statusStyle;
//
//   final Color? color;
//
//   final double height;
//   final Widget? child;
//   final bool showShadow;
//   const NavigationBar(
//       {Key? key,
//       this.statusStyle,
//       this.color,
//       this.height = 56,
//       this.child,
//       this.showShadow = true})
//       : super(key: key);
//
//   @override
//   State<NavigationBar> createState() => _NavigationBarState();
// }
//
// class _NavigationBarState extends State<NavigationBar> {
//   @override
//   Widget build(BuildContext context) {
//     // 获取provider
//     print("build nav bar");
//     var themeProvider = context.read<ThemeProvider>();
//     var setColor = widget.color ?? Colors.black;
//     var setStateStyle = widget.statusStyle ?? StatusStyle.Light;
//     if (widget.color == null || widget.statusStyle == null) {
//       setColor = themeProvider.appbarBackColor ?? Colors.black;
//       setStateStyle = themeProvider.stateStyle;
//     }
//     setStatusBar(setColor, setStateStyle);
//     // 状态栏高度
//     var top = MediaQuery.of(context).padding.top;
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: widget.height + top,
//       child: widget.child,
//       decoration: BoxDecoration(
//         color: widget.color ?? themeProvider.appbarBackColor,
//         boxShadow: widget.showShadow
//             ? [
//                 BoxShadow(
//                     color: Colors.black26,
//                     offset: Offset(0.0, 1.0), //阴影xy轴偏移量
//                     blurRadius: 5.0, //阴影模糊程度
//                     spreadRadius: 2.0 //阴影扩散程度
//                     )
//               ]
//             : null,
//       ),
//       padding: EdgeInsets.only(top: top),
//     );
//   }
// }

class NavigationBar extends StatelessWidget {
  final StatusStyle? statusStyle;

  final Color? color;

  final double height;
  final Widget? child;
  final bool showShadow;
  const NavigationBar(
      {Key? key,
      this.statusStyle,
      this.color,
      this.height = 56,
      this.child,
      this.showShadow = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 获取provider
    var themeProvider = Provider.of<ThemeProvider>(context);
    ;
    var setColor = color ?? Colors.black;
    var setStateStyle = statusStyle ?? StatusStyle.Light;
    if (color == null || statusStyle == null) {
      setColor = themeProvider.appbarBackColor ?? Colors.black;
      setStateStyle = themeProvider.stateStyle;
    }
    setStatusBar(setColor, setStateStyle);
    // 状态栏高度
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: this.height + top,
      child: this.child,
      decoration: BoxDecoration(
        color: setColor,
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
