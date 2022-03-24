// 高斯模糊
import 'dart:ui';

import 'package:flutter/material.dart';

class HiBlur extends StatelessWidget {
  final Widget? child;
  // 模糊值
  final double sigma;
  const HiBlur({Key? key, this.sigma = 10, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
      child: Container(
        child: child,
        color: Colors.white10,
      ),
    );
  }
}
