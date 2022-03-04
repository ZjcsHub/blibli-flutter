import 'package:flutter/cupertino.dart';

/// 首页状态异常处理
abstract class HiState<T extends StatefulWidget> extends State<T> {
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    } else {
      print("HiState 页面已销毁，本次setState不执行:${toString()}");
    }
  }
}
