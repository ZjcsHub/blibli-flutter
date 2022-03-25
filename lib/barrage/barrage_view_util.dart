import 'package:blibli/model/barrage_model.dart';
import 'package:flutter/material.dart';

class BarrageViewUtil {
  static barrageView(BarrageModel model) {
    return Text(
      model.context,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
    );
  }
}
