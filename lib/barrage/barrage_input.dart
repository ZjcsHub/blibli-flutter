import 'package:blibli/util/color.dart';
import 'package:blibli/util/view_util.dart';
import 'package:flutter/material.dart';

/// 弹幕输入界面
class BarrageInput extends StatelessWidget {
  final VoidCallback? onTabClose;
  const BarrageInput({Key? key, this.onTabClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController editingController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          // 空白区域
          Expanded(
              child: GestureDetector(
            onTap: () {
              if (onTabClose != null) {
                Navigator.of(context).pop();
              }
            },
            child: Container(
              color: Colors.transparent,
            ),
          )),
          SafeArea(
              child: Container(
            color: Colors.white,
            child: Row(
              children: [
                hiSpace(width: 15),
                _buildInput(editingController, context),
                _buildSendButton(editingController, context)
              ],
            ),
          ))
        ],
      ),
    );
  }

  _buildInput(TextEditingController editingController, BuildContext context) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        autofocus: true,
        controller: editingController,
        onSubmitted: (value) {
          _send(value, context);
        },
        cursorColor: primary,
        decoration: InputDecoration(
            isDense: true,
            contentPadding:
                EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            border: InputBorder.none,
            hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
            hintText: "发个友善的弹幕"),
      ),
    ));
  }

  _send(String value, BuildContext context) {
    if (value.isNotEmpty) {
      if (onTabClose != null) onTabClose!();
      Navigator.pop(context, value);
    }
  }

  _buildSendButton(
      TextEditingController editingController, BuildContext context) {
    return InkWell(
      onTap: () {
        var text = editingController.text.trim() ?? "";
        _send(text, context);
      },
      child: Container(
        child: Icon(
          Icons.send_rounded,
          color: Colors.grey,
        ),
        padding: EdgeInsets.all(10),
      ),
    );
  }
}
