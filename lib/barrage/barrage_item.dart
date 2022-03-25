import 'package:blibli/barrage/barrage_transition.dart';
import 'package:flutter/material.dart';

class BarrageItem extends StatelessWidget {
  final String? id;
  final double top;
  final Widget? child;
  final ValueChanged? onComplete;
  final Duration duration;

  BarrageItem(
      {Key? key,
      this.id,
      this.top = 0,
      this.child,
      this.onComplete,
      required this.duration})
      : super(key: key);

  var _key = GlobalKey<BarrageTransitionState>();
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        top: top,
        child: BarrageTransition(
          key: _key,
          onComplete: (value) {
            if (onComplete != null) onComplete!(this);
          },
          duration: duration,
          child: child,
        ));
  }
}
