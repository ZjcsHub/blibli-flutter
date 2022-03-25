import 'dart:async';
import 'dart:math';

import 'package:blibli/barrage/barrage_item.dart';
import 'package:blibli/barrage/barrage_view_util.dart';
import 'package:blibli/model/barrage_model.dart';
import "package:flutter/material.dart";

enum BarrageStatus { play, pause }

/// 弹幕组建
class HiBarrage extends StatefulWidget {
  final int lineCount;
  final String vid;
  final int speed;
  final double top;
  final bool autoPlay;

  final List<BarrageModel>? barrageLists;

  const HiBarrage(this.vid,
      {Key? key,
      this.lineCount = 4,
      this.speed = 800,
      this.top = 0,
      this.autoPlay = false,
      this.barrageLists})
      : super(key: key);

  @override
  State<HiBarrage> createState() => HiBarrageState();
}

class HiBarrageState extends State<HiBarrage> {
  double _height = 0;
  double _width = 0;
  List<BarrageItem> _barrageItemList = []; // 弹幕widget集合
  List<BarrageModel> _barrageModelList = []; // 弹幕模型

  // 第几条弹幕
  int _barrageIndex = 0;
  Random _random = Random();
  BarrageStatus _barrageStatus = BarrageStatus.pause;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.barrageLists != null) {
      _barrageModelList = widget.barrageLists!;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = _width / 16 * 9;
    return SizedBox(
      width: _width,
      height: _height,
      child: Stack(
        children: [
          //防止Stack的child为空
          Container()
        ]..addAll(_barrageItemList),
      ),
    );
  }

  void play() {
    _barrageStatus = BarrageStatus.play;
    if (_timer != null && _timer!.isActive) return;
    _timer = Timer.periodic(Duration(milliseconds: widget.speed), (timer) {
      if (_barrageModelList.isNotEmpty) {
        var temp = _barrageModelList.removeAt(0);
        addBarrage(temp);
        print("发送弹幕");
      } else {
        print("弹幕发送完毕");
        _timer?.cancel();
      }
    });
  }

  addBarrage(BarrageModel model) {
    double perRowHeight = 30;
    var line = _barrageIndex % widget.lineCount;
    _barrageIndex++;
    var top = line * perRowHeight + widget.top;
    // 为每一盒弹幕生成一个id
    String id = '${_random.nextInt(10000)}:${model.context}';
    var item = BarrageItem(
      id: id,
      top: top,
      child: BarrageViewUtil.barrageView(model),
      onComplete: (value) {
        print("Done:${value.id}");
        _barrageItemList.removeWhere((element) => element.id == value.id);
      },
      duration: Duration(milliseconds: model.duration),
    );
    _barrageItemList.add(item);
    setState(() {});
  }

  void pause() {
    _barrageStatus = BarrageStatus.pause;
    // 清除
    _barrageItemList.clear();
    setState(() {});

    print("action:pause");
    _timer?.cancel();
  }

  void send(BarrageModel model) {
    if (model.context.length == 0) return;
    _barrageModelList.add(model);

    if (_barrageStatus == BarrageStatus.play) {
      play();
      return;
    }
    if (widget.autoPlay && _barrageStatus != BarrageStatus.pause) {
      play();
    }
  }
}
